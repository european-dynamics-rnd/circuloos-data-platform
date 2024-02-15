import matplotlib.pyplot as plt
import numpy as np
import mpld3
from flask import Flask, render_template
from skimage import io
from skimage.color import rgb2gray
from skimage.filters import threshold_otsu
from skimage.measure import find_contours, approximate_polygon
import matplotlib.pyplot as plt
from shapely.geometry import Polygon
from shapely.plotting import plot_polygon
import random
import geojson


app = Flask(__name__)

# Create some data for the plot
x = np.linspace(0, 2 * np.pi, 100)
y = np.sin(x)

@app.route("/")
def index():

    
    image_path_white = './CIRCOLOOS_leatherboard_white.jpg'
    width_real=100 # in cm
    heigh_real=100 # in cm


    image_white = io.imread(image_path_white)
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
    shapes_surface_m2_white=[]
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

    print(f"Entire (outline) sheet area: {initial_image_polygon_area_real:.2f}cm2, remaining leather: {remaining_polygon_area_real:.2f}, cut area: {areaPolygon_white_real:.2f}cm2")
    print(f"ratio remaining: {ration_remaining:.2f} %, sanity check : {areaPolygon_white_real+remaining_polygon_area_real}cm2")

    # Convert the Shapely polygon to a GeoJSON Feature
    features = geojson.Feature(geometry=remaining_polygon, properties={})
    # Convert the Feature to a GeoJSON FeatureCollection (optional, but common)
    feature_collection = geojson.FeatureCollection([features])
    features_coorinates=feature_collection['features'][0]['geometry']['coordinates']

    features_coorinates_real = [
        [[x * pixel_width_real, y * pixel_heigh_real] for x, y in sub_list]
        for sub_list in features_coorinates
    ]

    
    fig, ax = plt.subplots()
    # Create the Matplotlib plot
    ax.set_title("Sine Wave")
    plot_polygon(remaining_polygon, ax=ax, add_points=False, alpha=0.2)
    for n, contour in enumerate(shapes_coordinates_white):
        color = '#' + ''.join(random.choice('0123456789ABCDEF') for _ in range(6))  # Random color code
        plot_polygon(Polygon(contour), ax=ax, color=color,add_points=False, alpha=0.8)

    # x_min, y_min, x_max, y_max = remaining_polygon.bounds
    # ax.set_xlim(x_min, x_max)
    # ax.set_ylim(y_min, y_max)
    # plt.show()


    # Convert the Matplotlib plot to an interactive HTML representation using mpld3
    html_plot = mpld3.fig_to_html(fig)

    return render_template("index.html", html_plot=html_plot)

if __name__ == "__main__":
    # Run the Flask application on port 5005
    app.run(port=5005)