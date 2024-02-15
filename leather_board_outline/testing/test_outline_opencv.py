import cv2
import os
os.environ['QT_QPA_PLATFORM'] = 'offscreen'
import numpy as np
import matplotlib.pyplot as plt
# We need to invert the binarization to get the white shapes as foreground


image_path_white = './CIRCOLOOS_leatherboard_white.jpg'
image = cv2.imread(image_path_white)

# Convert to grayscale
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# Apply Otsu's thresholding to get a binary image
_, binary_image_white_cv = cv2.threshold(gray_image, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)
binary_image_white_cv_inv = cv2.bitwise_not(binary_image_white_cv)
# Find contours again with the inverted binary image
contours_white_cv_inv, _ = cv2.findContours(binary_image_white_cv_inv, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

# Initialize a list to hold the coordinates of the approximated contours
shapes_coordinates_white_cv_inv = []

# Loop through the contours and approximate them
for contour in contours_white_cv_inv:
    epsilon = 0.01 * cv2.arcLength(contour, True)
    approx = cv2.approxPolyDP(contour, epsilon, True)
    shapes_coordinates_white_cv_inv.append(approx.reshape(-1, 2))

# Plot the contours over the inverted binary image for better visibility

fig, ax = plt.subplots()
ax.imshow(binary_image_white_cv_inv, cmap='gray')

for contour in shapes_coordinates_white_cv_inv:
    ax.plot(contour[:, 0], contour[:, 1], linewidth=2)



ax.axis('image')
ax.set_xticks([])
ax.set_yticks([])
plt.show()

# Output the number of shapes detected and some of the coordinates
len(shapes_coordinates_white_cv_inv), shapes_coordinates_white_cv_inv[:2]  # Show the coordinates of first two shapes as an example
