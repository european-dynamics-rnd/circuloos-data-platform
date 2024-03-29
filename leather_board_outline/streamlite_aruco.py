import streamlit as st
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.pyplot as plt
from shapely.geometry import Polygon
import outline_detection_fabric_irregural
import json

# Read the JSON file
with open('streamlite_aruco_options.json', 'r') as f:
    streamlite_aruco_options = json.load(f)

  
exported_coordinates=None
statistics=""

with st.sidebar:
    uploaded_jpg = st.file_uploader("Upload the leather sheet Image", type=["jpg", "jpeg"])


# Create a Streamlit app
st.title("CIRCOLOOS Leather outline with ArUco markers")

# Create a checkbox to toggle visibility of Plot 1
plot1_visible = st.checkbox("Show remaining leather board", value=True)
# # Create a button to update Plot 1
# if st.button("Update Plot 1"):
#     y1 = 2 * np.sin(x)

col1, col2 = st.columns(2)
if uploaded_jpg is not None:
    with col1:
        st.image(uploaded_jpg, caption='Loaded image', use_column_width=True)

if uploaded_jpg is not None:
    with col2:
        error=None
        try:
            outline=outline_detection_fabric_irregural.caclulation(uploaded_jpg)
            polygon = Polygon(outline['coordinates'][0])
            # Get the area of the polygon
            area = polygon.area
            # print(outline_area)
            statistics=f"Area of the leather: {area:.4f} cm2"
            coordinates = outline['coordinates'][0]
            # Extract x and y coordinates
            x_coords = [point[0] for point in coordinates]
            y_coords = [point[1] for point in coordinates]

        except ValueError as e:
            error=e
            print(e)
        
        if error is not None:
             st.error(error)  
        else:
            # Create the Matplotlib plots
            # print(f"outline:{outline}")
            fig1, ax1 = plt.subplots()
            ax1.plot(x_coords, y_coords)
            ax1.set_title("Remaining leather board")
            ax1.set_xlabel('cm')
            ax1.set_ylabel('cm')
            # Display the plots based on visibility flags
            if plot1_visible:
                st.pyplot(fig1)

if uploaded_jpg is not None:
    st.text(statistics)
    st.download_button("Download Coordinates of remaining board", '"'+str(outline["coordinates"][0])+'"', key='download_button', file_name='output.txt')
    selection={}
    selection["leather_type"]=st.selectbox("Leather type",streamlite_aruco_options["input"]["Leather type"])
    if selection["leather_type"]=="animal":
        selection["kind_of_animal"]=st.selectbox("Kind of animal",streamlite_aruco_options["input"]["Kind of animal"])
    elif selection["leather_type"]=="vegan":
        selection["kind_of_plant"]=st.selectbox("Kind of plant",streamlite_aruco_options["input"]["Kind of plant"])
    selection["leather_type_tanned"]=st.selectbox("Leather Type/tanned",streamlite_aruco_options["input"]["Leather Type/tanned"])
    selection["grainsided"]=st.selectbox("Grainsided",streamlite_aruco_options["input"]["Grainsided"])
    selection["leather_type_covered"]=st.selectbox("Leather type/covered",streamlite_aruco_options["input"]["Leather type/covered"])
    selection["non_covered"]=st.selectbox("Non-covered",streamlite_aruco_options["input"]["Non-covered"])
    selection["colour_homogeneity"]=st.selectbox("Colour homogeneity",streamlite_aruco_options["input"]["Colour homogeneity"])
    selection["brightness"]=st.selectbox("Brightness",streamlite_aruco_options["input"]["Brightness"])
    selection["hardness"]=st.selectbox("Hardness",streamlite_aruco_options["input"]["Hardness"])
    selection["colour"]=st.selectbox("Colour",streamlite_aruco_options["input"]["Colour"])
    if selection["colour"]=="other colour":
        selection["colour"]=st.color_picker('Select a color')
    selection["thickness"]=st.number_input("Tickness (mm)")
    

    

    