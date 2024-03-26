from skimage import io, color
from skimage.feature import canny
import matplotlib.pyplot as plt
from scipy import ndimage as ndi
import numpy as np

# Load the image
image_path = './fabric_1_no_ruller_no_aruco.jpg'
image = io.imread(image_path)

# Convert the image to grayscale
gray_image = color.rgb2gray(image)

# Determine the mean intensity of the grayscale image and set thresholds based on it
mean_intensity = np.mean(gray_image)
low_threshold = mean_intensity / 2
high_threshold = mean_intensity

# Apply Canny edge detection with the new thresholds
edges_threshold = canny(gray_image, low_threshold=low_threshold, high_threshold=high_threshold)
print(f"edges_threshold:{edges_threshold}")
# Create an output image with a white background and the same size as the original
output_image_threshold = np.ones_like(image) * 255

# Set the edges to red on the output image using the thresholded edges
output_image_threshold[edges_threshold] = [255, 0, 0]  # Red

# Show the original, the previous edge-overlayed, and the new edge-overlayed images with threshold
fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(18, 6),
                         sharex=True, sharey=True)
ax = axes.ravel()

ax[0].imshow(image)
ax[0].set_title('Original Image')
ax[0].axis('off')

ax[1].imshow(output_image_threshold)
ax[1].set_title('Red Outline with Threshold')
ax[1].axis('off')

plt.tight_layout()
plt.show()








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
