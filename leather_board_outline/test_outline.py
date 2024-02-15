
import outline_detection
from shapely.plotting import plot_polygon
import random
import matplotlib.pyplot as plt
from shapely.geometry import Polygon

"""
A simple tool to extract the outline of a leather board with removed material. The resulting polygon in real coodinates in cm
The removed material is indicated by a white area on the image

"""

# Load the new image with white shapes
# image_path_white = './CIRCOLOOS_leatherboard_white_40.jpg'
image_path_white = './CIRCOLOOS_leatherboard_white.jpg'
width_real=100 # in cm
heigh_real=100 # in cm

remaining_polygon, remaining_polygon_coorinates_real, shapes_coordinates_white= outline_detection.outline_detection_white_backround(image_path_white, width_real, heigh_real)

# print(f"remaining_polygon: {remaining_polygon}")
# print(f"remaining_polygon_coorinates_real: {remaining_polygon_coorinates_real} in cm")

with open('output.txt', "w") as file:
    file.write('"'+str(remaining_polygon_coorinates_real)+'"')

# Plot the contours over the original image to verify correctness
fig, ax = plt.subplots()
plot_polygon(remaining_polygon, ax=ax, add_points=False, alpha=0.2)
for n, contour in enumerate(shapes_coordinates_white):
    color = '#' + ''.join(random.choice('0123456789ABCDEF') for _ in range(6))  # Random color code
    plot_polygon(Polygon(contour), ax=ax, color=color,add_points=False, alpha=0.8)

x_min, y_min, x_max, y_max = remaining_polygon.bounds
ax.set_xlim(x_min, x_max)
ax.set_ylim(y_min, y_max)
plt.show()

