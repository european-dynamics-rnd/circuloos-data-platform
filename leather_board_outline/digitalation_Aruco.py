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



# Function to generate a random color
def random_color():
    return [random.uniform(0, 1) for _ in range(3)]

def outline(image):
    # image = io.imread(image_path)
    # Flip the image horizontally (along the vertical axis)
    image = np.fliplr(image)
# Convert the image to grayscale
    gray_image_white = color.rgb2gray(image)

    # Binarize the image based on thresholding
    thresh_white = threshold_otsu(gray_image_white)
    print(f"thresh_white:{thresh_white}")
    binary_image_white = gray_image_white < thresh_white  # This time we invert the threshold for white shapes
    # Find contours at a constant value of 0.8
    contours_white = find_contours(binary_image_white, 0.9)
    shapes_coordinates_white = []
    # the polygon of the leather board to be recycled 
    # go thou all shapes that have been removed - indicated by white in the original image !!!
    for contour in contours_white:
        # Approximate the contour to reduce the number of points
        approx = approximate_polygon(contour, tolerance=0.1)
        try:
            area=Polygon(approx).area
        except:
            print(f"problematic polygon: {approx}")
            continue
        if (area>10):
            print(f"Polygon:{contour}, area:{area}")
            shapes_coordinates_white.append(approx)

    # Plot the image
    # fig, ax = plt.subplots()
    # ax.imshow(image, cmap='gray')

    # # Plot each shape on top of the image
    # for shape in shapes_coordinates_white:
    #     ax.plot(shape[:, 1], shape[:, 0], linewidth=2, color=random_color())

    # plt.show()

def aruco_pixel_to_cm(image, ACUCO_MARKER):
    # Define Aruco dictionary (Choose the one matching your markers)
    dictionary = cv2.aruco.getPredefinedDictionary(ACUCO_MARKER)
    # parameters = aruco.DetectorParameters_create()
    parameters = cv2.aruco.DetectorParameters()

    # Detect markers 
    detector = cv2.aruco.ArucoDetector(dictionary, parameters) 
    corners, ids, rejectedImgPoints = detector.detectMarkers(image) 
    # Draw detected markers (optional)
    cv2.aruco.drawDetectedMarkers(image, corners, ids)

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

    # Define the real size of your markers (in cm), e.g., {markerID: sizeInCm}
    real_marker_sizes = {0: 5.0, 1: 5.0}  # example sizes for marker IDs 0, 1

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
                pixel_to_cm_ratios[markerID] = pixel_to_cm_ratio

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
    return image

# Load the image
image = cv2.imread("fabric_1_no_ruller.jpg")
image_without_aruco=aruco_pixel_to_cm(image,cv2.aruco.DICT_7X7_100)
# cv2.imwrite("fabric_1_no_ruller_without_aruco_2.jpg", image_without_aruco)
# # Display the image (optional)
# cv2.imshow("Image", image_without_aruco)
# cv2.waitKey(10000)
# cv2.destroyAllWindows()
outline(image_without_aruco)
            
            
# # Display the image (optional)
# cv2.imshow("Image", image_without_aruco)
# cv2.waitKey(10000)
# cv2.destroyAllWindows()
