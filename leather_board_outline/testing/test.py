from shapely.geometry import Polygon
from matplotlib import pyplot as plt
from descartes import PolygonPatch
from shapely.plotting import plot_polygon



# Define the large polygon
large_polygon = Polygon([(0, 0), (10, 0), (10, 10), (0, 10)])

# Define an internal shape to add as a patch
internal_shape = Polygon([(2, 2), (5, 2), (5, 5), (2, 5)])

# Create a new polygon by combining the large polygon and the internal shape
resulting_polygon = large_polygon.difference(internal_shape)

# Plotting
fig, ax = plt.subplots()
# ax.add_patch(PolygonPatch(resulting_polygon, alpha=0.5, fc='r'))
plot_polygon(resulting_polygon, ax=ax, add_points=False, alpha=0.2)

ax.set_xlim([0, 10])
ax.set_ylim([0, 10])
plt.show()