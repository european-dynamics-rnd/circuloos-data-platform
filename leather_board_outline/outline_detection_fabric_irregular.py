import cv2
import numpy as np
import random

from skimage import io, color, measure
from skimage.feature import canny
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.pyplot as plt
import random
from shapely.geometry import Polygon
from shapely.geometry import LineString
from skimage.filters import threshold_otsu
from skimage.measure import find_contours, approximate_polygon
import geojson
from shapely.ops import cascaded_union




# Function to generate a random color
def random_color():
    return [random.uniform(0, 1) for _ in range(3)]

def calculate_average_pixel_to_cm_ratio(pixel_to_cm_ratio_dict):
    print(f"pixel_to_cm_ratio: {pixel_to_cm_ratio_dict}")
    sum=0
    for index, pixel_to_cm_ratio in pixel_to_cm_ratio_dict.items():
        sum=pixel_to_cm_ratio["pixel_to_cm_ratio"]+sum
    return sum/len(pixel_to_cm_ratio_dict)


def polygon_to_geojson(outline_polygon,average_pixel_to_cm_ratio):
    coordinates_np=outline_polygon[0]
    # Find the minimum x and y coordinates
    min_x = np.min(coordinates_np[:, 0])
    min_y = np.min(coordinates_np[:, 1])

    # Translate the polygon by subtracting the minimum coordinates
    coordinates_np[:, 0] -= min_x
    coordinates_np[:, 1] -= min_y

    outline_polygon=average_pixel_to_cm_ratio*coordinates_np
    coordinates = outline_polygon.tolist()
    # Convert the Shapely polygon to a GeoJSON Feature
    outline_polygon = geojson.Polygon([coordinates])
    # print(f"outline_polygon:{outline_polygon}")
    # Convert the Feature to a GeoJSON FeatureCollection (optional, but common)
    return outline_polygon
    
    
def outline_detection(image):
    # image = io.imread(image_path)
    # Flip the image horizontally (along the vertical axis)
    # image = np.fliplr(image)
# Convert the image to grayscale
    gray_image_non_white = color.rgb2gray(image)

    # Binarize the image based on thresholding
    thresh_non_white = threshold_otsu(gray_image_non_white)
    print(f"thresh_non_white:{thresh_non_white}")
    binary_image_non_white = gray_image_non_white < thresh_non_white  # This time we invert the threshold for white shapes
    # Find contours at a constant value of 0.8
    contours_non_white = find_contours(binary_image_non_white, 0.9)
    shapes_coordinates_non_white = []
    # the polygon of the leather board to be recycled 
    # go thou all shapes that have been removed - indicated by white in the original image !!!
    for contour in contours_non_white:
        # Approximate the contour to reduce the number of points
        approx = approximate_polygon(contour, tolerance=0.1)
        try:
            area=Polygon(approx).area
        except:
            print(f"problematic polygon: {approx}")
            continue
        if (area>10):
            # print(f"Polygon :{contour}, area:{area}")
            approx=Polygon(approx)
            print(f"initial polygon number of :{len(approx.exterior.coords)}")
            tolerance = 1 
            simplified_polygon = approx.simplify(tolerance, preserve_topology=True)
            print(f"approx polygon number of :{len(simplified_polygon.exterior.coords)}")
            shapes_coordinates_non_white.append(np.array(approx.exterior.coords))

            
    return shapes_coordinates_non_white


def aruco_pixel_to_cm(image, ARUCO_MARKER, real_marker_sizes):
    # Define Aruco dictionary (Choose the one matching your markers)
    dictionary = cv2.aruco.getPredefinedDictionary(ARUCO_MARKER)
    # parameters = aruco.DetectorParameters_create()
    parameters = cv2.aruco.DetectorParameters()

    # Detect markers 
    detector = cv2.aruco.ArucoDetector(dictionary, parameters) 
    corners, ids, rejectedImgPoints = detector.detectMarkers(image) 
    # Draw detected markers (optional)
    cv2.aruco.drawDetectedMarkers(image, corners, ids)
    if ids is None:
        # no aruco makers have been found
        raise ValueError("No Aruco marker found")
    # Process information based on detected markers
    if ids is not None:
        for i in range(len(ids)):
            # Get marker center by averaging corner points 
            center = sum(corners[i][0]) / 4  
            # Example: Print marker ID and center coordinates
            print(f"Marker ID:{ids[i]}, Center: {center}")
            # print(f"Coordinates: {corners}")
            
    # Initialize the conversion ratio
    pixel_to_cm_ratio = None

    # Initialize dictionary for conversion ratios
    pixel_to_cm_ratios = {}

    # Check that at least one ArUco marker was detected
    if len(corners) > 0:
        # Flatten the ArUco IDs list
        ids_flatten = ids.flatten()
       # Loop over the detected ArUco corners
        for (markerCorner, markerID) in zip(corners, ids_flatten):
            # Check if the markerID is in the dictionary of real marker sizes
            if markerID in real_marker_sizes:
                # Extract the marker corners
                corners_local = markerCorner.reshape((4, 2))
                (topLeft, topRight, bottomRight, bottomLeft) = corners_local

                # Compute the width and height of the marker
                markerWidth = np.linalg.norm(topRight - topLeft)
                markerHeight = np.linalg.norm(topRight - bottomRight)
                
                # The pixel dimensions of the marker
                markerDimensions = (markerWidth + markerHeight) / 2

                # Calculate the conversion ratio (cm/pixel)
                pixel_to_cm_ratio = real_marker_sizes[markerID] / markerDimensions

                # Store the conversion ratio in the dictionary
                pixel_to_cm_ratios[markerID] = {"pixel_to_cm_ratio": pixel_to_cm_ratio,"markerWidth":markerWidth,"markerHeight":markerHeight}

                # Print the conversion ratio for each marker
                print(f"Marker ID: {markerID}, Conversion Ratio: {pixel_to_cm_ratio:.5f} cm/pixel")
                print(f"Marker ID: {markerID}: markerWidth:{markerWidth:.3f}, markerHeight:{markerHeight:.3f}")
                # print(f"corners: {corners_local}")
                
    # Cover all the aruco with a white 
    # Check that at least one ArUco marker was detected
    buffer_size = 10
    if len(corners) > 0:
        # Flatten the ArUco IDs list
        ids_flatten = ids.flatten()

        # Loop over the detected ArUco corners
        for (markerCorner, markerID) in zip(corners, ids_flatten):
            # Check if the markerID is in the dictionary of real marker sizes
            if markerID in real_marker_sizes:
                # Extract the marker corners
                corners_local = markerCorner.reshape((-1, 2))

                # Add buffer around marker corners
                buffer = np.array([[-buffer_size, -buffer_size],
                                   [buffer_size, -buffer_size],
                                   [buffer_size, buffer_size],
                                   [-buffer_size, buffer_size]])
                buffered_corners = corners_local + buffer
                # print(f"buffered_corners:{buffered_corners}")
                # Fill marker area with white color
                cv2.fillPoly(image, [np.int32(buffered_corners)], (255, 255, 255))
    return image,pixel_to_cm_ratios

def caclulation(filename,ARUCO_MARKER,real_marker_sizes):
    # Define the real size of your markers (in cm), e.g., {markerID: sizeInCm}
    # ARUCO_MARKER= cv2.aruco.DICT_7X7_10
        # real_marker_sizes = {0: 5.0, 1: 5.0}  # example sizes for marker IDs 0, 1?

    # Load the image
    # filename="fabric_1_no_ruller.jpg"
    image = io.imread(filename)
    
    image_without_aruco,pixel_to_cm_ratio_dict=aruco_pixel_to_cm(image,ARUCO_MARKER,real_marker_sizes)
    average_pixel_to_cm_ratio=calculate_average_pixel_to_cm_ratio(pixel_to_cm_ratio_dict)
    print(f" average_pixel_to_cm_ratio:{average_pixel_to_cm_ratio}")

    shapes_coordinates_non_white=outline_detection(image_without_aruco)
    # print(f"shapes_coordinates_non_white:{shapes_coordinates_non_white} type{type(shapes_coordinates_non_white[0])}")

    polygon_geojson=polygon_to_geojson(shapes_coordinates_non_white,average_pixel_to_cm_ratio)
      

    return polygon_geojson       
          
            
            
# cv2.imwrite("fabric_1_no_ruller_without_aruco_2.jpg", image_without_aruco)
# # Display the image (optional)
# cv2.imshow("Image", image_without_aruco)
# cv2.waitKey(10000)
# cv2.destroyAllWindows()
# # Display the image (optional)
# cv2.imshow("Image", image_without_aruco)
# cv2.waitKey(10000)
# cv2.destroyAllWindows()
