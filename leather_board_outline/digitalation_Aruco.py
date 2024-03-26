import cv2
import numpy as np
# import cv2.aruco as aruco


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
                corners = markerCorner.reshape((4, 2))
                (topLeft, topRight, bottomRight, bottomLeft) = corners

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
                print(f"corners: {corners}")

# Load the image
image = cv2.imread("fabric_1_no_ruller.jpg")
# aruco_pixel_to_cm(image,cv2.aruco.DICT_7X7_100)

            
            
# Display the image (optional)
cv2.imshow("Image", image)
cv2.waitKey(10000)
cv2.destroyAllWindows()
