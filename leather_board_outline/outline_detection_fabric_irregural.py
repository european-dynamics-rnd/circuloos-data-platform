from skimage import io, color, measure
from skimage.feature import canny
import matplotlib.pyplot as plt
from scipy import ndimage as ndi
import numpy as np
import matplotlib.pyplot as plt
import random
import shapely
from shapely.geometry import Polygon
from shapely.ops import unary_union
from shapely.geometry import LineString
from skimage.filters import threshold_otsu
from skimage.measure import find_contours, approximate_polygon

# Function to generate a random color
def random_color():
    return [random.uniform(0, 1) for _ in range(3)]

# Load the image
# image_path = './fabric_1_no_ruller_no_aruco.jpg'
image_path="./fabric_1_no_ruller_without_aruco_2.jpg"

image = io.imread(image_path)
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
fig, ax = plt.subplots()
ax.imshow(image, cmap='gray')

# Plot each shape on top of the image
for shape in shapes_coordinates_white:
    ax.plot(shape[:, 1], shape[:, 0], linewidth=2, color=random_color())

plt.show()








# Determine the mean intensity of the grayscale image and set thresholds based on it
# mean_intensity = np.mean(gray_image)
# low_threshold = mean_intensity / 2
# high_threshold = mean_intensity

# # Apply Canny edge detection with the new thresholds
# edges_threshold = canny(gray_image, low_threshold=low_threshold, high_threshold=high_threshold)
# # print(f"edges_threshold:{edges_threshold}")

# # Find contours from the edges
# contours = measure.find_contours(edges_threshold, level=0.8)

# # Combine all LineString objects into a single geometry
# combined_lines = unary_union([LineString(contour) for contour in contours])

# # Attempt to create a polygon from the combined line strings
# combined_polygon = None
# try:
#     # The polygonize function returns an iterator of Polygon objects
#     polygons = list(polygonize([combined_lines]))

#     # For simplicity, we'll just use the first polygon if multiple are found
#     if polygons:
#         combined_polygon = polygons[0]
# except Exception as e:
#     print(f"Error in forming polygon: {e}")

# # Plotting the result
# fig, ax = plt.subplots()
# # ax.imshow(image)

# # If a polygon was successfully created, draw it
# if combined_polygon:
#     x, y = combined_polygon.exterior.xy
#     ax.plot(x, y, color=random_color(), linewidth=2)

# plt.show()


# # ConvexHull does not work  
# from scipy.spatial import ConvexHull
# # Combine all the points in the polygons into a single array
# all_points = np.vstack(polygons)

# # Compute the convex hull
# hull = ConvexHull(all_points)

# # Extract the vertices of the convex hull
# hull_vertices = all_points[hull.vertices]

# # Plotting
# fig, ax = plt.subplots()
# ax.imshow(image, cmap=plt.cm.gray)

# # Draw the convex hull
# ax.plot(hull_vertices[:, 1], hull_vertices[:, 0], color='lime', lw=2)
# ax.fill(hull_vertices[:, 1], hull_vertices[:, 0], color='lime', alpha=0.3)

# ax.set_title('Image with Combined Convex Hull')
# ax.axis('off')
# plt.show()


# #print polygon 
# # Output the polygons
# polygon_output = [polygon.tolist() for polygon in polygons]
# print(f"polygon_output{polygon_output}")  # Display the first 5 polygons for preview (the full list may be very long)

# # Draw the polygons on top of the image
# fig, ax = plt.subplots()
# ax.imshow(image, cmap=plt.cm.gray)

# for polygon in polygons:
#     # Draw the polygon
#     ax.plot(polygon[:, 1], polygon[:, 0], color=random_color())

# ax.set_title('Image with Polygon Outlines')
# ax.axis('off')
# plt.show()




# Create an output image with a white background and the same size as the original
# output_image_threshold = np.ones_like(image) * 255

# # Set the edges to red on the output image using the thresholded edges
# output_image_threshold[edges_threshold] = [255, 0, 0]  # Red

# # Show the original, the previous edge-overlayed, and the new edge-overlayed images with threshold
# fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(18, 6),
#                          sharex=True, sharey=True)
# ax = axes.ravel()

# ax[0].imshow(image)
# ax[0].set_title('Original Image')
# ax[0].axis('off')

# ax[1].imshow(output_image_threshold)
# ax[1].set_title('Red Outline with Threshold')
# ax[1].axis('off')

# plt.tight_layout()
# plt.show()








# # Apply edge detection (Canny)
# edges = canny(gray_image)

# # Show the original and the edge-detected images
# fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(12, 5),
#                          sharex=True, sharey=True)
# ax = axes.ravel()

# ax[0].imshow(image)
# ax[0].set_title('Original Image')
# ax[0].axis('off')

# ax[1].imshow(edges, cmap=plt.cm.gray)
# ax[1].set_title('Edge Detection')
# ax[1].axis('off')

# plt.tight_layout()
# plt.show()
