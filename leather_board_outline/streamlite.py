import streamlit as st
import matplotlib.pyplot as plt
import numpy as np
import outline_detection
from shapely.plotting import plot_polygon
import random
import matplotlib.pyplot as plt
from shapely.geometry import Polygon
import matplotlib.image as mpimg
from PIL import Image

# image_path_white = './CIRCOLOOS_leatherboard_white.jpg'
# width_real=100 # in cm
# heigh_real=100 # in cm
exported_coordinates=None
statistics=""
with st.sidebar:
    width_real = st.number_input("Enter width in cm", value=100.0)
    heigh_real = st.number_input("Enter height in cm", value=100.0)
    uploaded_jpg = st.file_uploader("Upload the leather sheet Image", type=["jpg", "jpeg"])



# Create a Streamlit app
st.title("CIRCOLOOS Leather outline")

# Create a checkbox to toggle visibility of Plot 1
plot1_visible = st.checkbox("Show remaining leather board", value=True)
plot2_visible = st.checkbox("Show removed material", value=True)
# # Create a button to update Plot 1
# if st.button("Update Plot 1"):
#     y1 = 2 * np.sin(x)

col1, col2 = st.columns(2)
if uploaded_jpg is not None:
    with col1:
        st.image(uploaded_jpg, caption='Loaded image', use_column_width=True)

if uploaded_jpg is not None:
    with col2:
        remaining_polygon, remaining_polygon_coorinates_real, shapes_coordinates_white, statistics= outline_detection.outline_detection_full_image(uploaded_jpg, width_real, heigh_real)
        exported_coordinates=remaining_polygon_coorinates_real
    # Create the Matplotlib plots
        fig1, ax1 = plt.subplots()
        plot_polygon(remaining_polygon, ax=ax1, add_points=False, alpha=0.2)
        ax1.set_title("Remaining leather board")

        fig2, ax2 = plt.subplots()
        for n, contour in enumerate(shapes_coordinates_white):
            color = '#' + ''.join(random.choice('0123456789ABCDEF') for _ in range(6))  # Random color code
            plot_polygon(Polygon(contour), ax=ax2, color=color,add_points=False, alpha=0.8)
        ax2.set_title("Removed material")

        # Display the plots based on visibility flags
        if plot1_visible:
            st.pyplot(fig1)
        if plot2_visible:   
            st.pyplot(fig2)
if uploaded_jpg is not None:
    st.text(statistics)
    st.download_button("Download Coordinates of remaining board", '"'+str(exported_coordinates)+'"', key='download_button', file_name='output.txt')