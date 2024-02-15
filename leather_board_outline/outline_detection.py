from skimage import io
from skimage.color import rgb2gray
from skimage.filters import threshold_otsu
from skimage.measure import find_contours, approximate_polygon
from shapely.geometry import Polygon
import geojson
import numpy as np

def outline_detection_white_backround(image_path:str,width_real:int, heigh_real:int,showStatistics=True ):
    image_white = io.imread(image_path)
    # Flip the image horizontally (along the vertical axis)
    image_white = np.fliplr(image_white)
    pixels_height, pixels_width  = image_white.shape[:2]
    initial_image_polygon = Polygon([(0, 0), (pixels_width, 0), (pixels_width, pixels_height), (0, pixels_height)]) 
    initial_image_polygon_area=initial_image_polygon.area 

    # Convert to grayscale
    gray_image_white = rgb2gray(image_white)
    # calculating ratio to translate to real measurements
    real_area=width_real * heigh_real
    polygon_ratio= real_area/initial_image_polygon_area

    pixel_width_real=width_real/pixels_width
    pixel_heigh_real=heigh_real/pixels_height

    # Binarize the image based on thresholding
    thresh_white = threshold_otsu(gray_image_white)
    binary_image_white = gray_image_white < thresh_white  # This time we invert the threshold for white shapes
    # Find contours at a constant value of 0.8
    contours_white = find_contours(binary_image_white, 0.8)
    # shapes of removed shapes inside the leather board
    shapes_coordinates_white = []
    # the polygon of the leather board to be recycled 
    remaining_polygon=initial_image_polygon
    areaPolygon_white_real=0
    # go thou all shapes that have been removed - indicated by white in the original image !!!
    for contour in contours_white:
        # Approximate the contour to reduce the number of points
        approx = approximate_polygon(contour, tolerance=0.1)
        try:
            area=Polygon(approx).area
        except:
            # print(f"problematic polygon: {approx}")
            continue
        if area > 10:
            shapes_coordinates_white.append(approx)
            areaPolygon_white_real=areaPolygon_white_real + Polygon(approx).area * polygon_ratio
            remaining_polygon = remaining_polygon.difference(Polygon(approx))
    
    
    remaining_polygon_area_real=remaining_polygon.area *polygon_ratio
    initial_image_polygon_area_real=initial_image_polygon_area*polygon_ratio
    ration_remaining=(initial_image_polygon_area_real-areaPolygon_white_real)/initial_image_polygon_area_real * 100
    should_be_zero=initial_image_polygon_area_real - (areaPolygon_white_real+remaining_polygon_area_real)
    statistics=f'''Entire (outline) sheet area: {initial_image_polygon_area_real:.2f}cm2,
    remaining leather: {remaining_polygon_area_real:.2f}cm2,
    cut area: {areaPolygon_white_real:.2f}cm2,
    ratio remaining: {ration_remaining:.2f} %,
    sanity check : {should_be_zero:.2f}cm2'''
    
    if showStatistics:
        print(statistics)

        

    # Convert the Shapely polygon to a GeoJSON Feature
    remaining_polygons = geojson.Feature(geometry=remaining_polygon, properties={})
    # Convert the Feature to a GeoJSON FeatureCollection (optional, but common)
    remaining_polygons_collection = geojson.FeatureCollection([remaining_polygons])
    remaining_polygon_coorinates=remaining_polygons_collection['features'][0]['geometry']['coordinates']
    remaining_polygon_coorinates_real = [
        [[x * pixel_width_real, y * pixel_heigh_real] for x, y in sub_list]
        for sub_list in remaining_polygon_coorinates
    ]
    
    return remaining_polygon, remaining_polygon_coorinates_real, shapes_coordinates_white, statistics