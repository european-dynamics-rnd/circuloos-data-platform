import streamlit as st
from ngsildclient import Entity

import matplotlib.pyplot as plt
import numpy as np
import matplotlib.pyplot as plt
from shapely.geometry import Polygon
import outline_detection_fabric_irregular
import json
import string
import random
import csv_ngsild_agent_utils as utlis
import streamlit_shadcn_ui as ui

def json_to_markdown(json_data, indent=0):
    markdown = ""
    for key, value in json_data.items():
        if isinstance(value, dict):
            markdown += "  " * indent + "- **{}:**\n".format(key)
            markdown += json_to_markdown(value, indent + 1)
        else:
            markdown += "  " * indent + "- **{}:** {}\n".format(key, value)
    return markdown

def generate_ngsi_ld(selection):
    # print(f"selection: {selection}")
    empty_properties=""
    for keys,data in selection.items():
        if len(str(data)) == 0:
            empty_properties=empty_properties+keys+", "
    # remove the last ", "
    if len(empty_properties)>0:
        empty_properties=empty_properties[:-2]
        empty_properties=empty_properties.replace("_"," ")
        print(f"empty_properties: {empty_properties}")
        st.error("Empty properties detected please fill them: \n"+empty_properties)
        # return an empty JSON
        return Entity("leather","urn:ngsi-ld:leather:empty")
    config=utlis.get_config()
    entity_ngsild=utlis.generate_ngsild_entity(selection,config['CONTEXT_JSON'])
    # json_entyty=json.loads(entity_ngsild.to_json())
    return entity_ngsild

# Initialize session_state
def init_session_state():
    if 'entity_ngsild' not in st.session_state:
        st.session_state.entity_ngsild = None
        
# Main Streamlit app
def main():    
    init_session_state()
    exported_coordinates=None
    statistics=""
    # holds the NGSI-LD entity of current piece of material

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
                statistics=f"Area of the leather: {area:.2f} cm2"
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
            # Read the JSON file
        with open('streamlite_aruco_options.json', 'r') as f:
            streamlite_aruco_options = json.load(f)
        st.text(statistics)
        st.download_button("Download Coordinates of remaining board", '"'+str(outline["coordinates"][0])+'"', key='download_button', file_name='output.txt')
        selection={}
        selection["id"]=st.text_input("id", "urn:ngsi-ld:circuloos:leather:"+''.join(random.choices(string.ascii_lowercase +string.digits, k=10)))
        selection["type"]=st.text_input("NGSI-LD type", "leather")
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
        # adding the unitCode 
        selection["thickness_unitCode"]="MMT"
        # testing 
        # selection_json="""{"id": "urn:ngsi-ld:circuloos:leather:iwhqjqd3rm", "type": "leather", "leather_type": "animal", "kind_of_animal": "cow", "leather_type_tanned": "tanned", "grainsided": "grainside ", "leather_type_covered": "covered/finished", "non_covered": "natur", "colour_homogeneity": "multicolored", "brightness": "bright", "hardness": "medium", "colour": "red", "thickness": 0.08, "thickness_unitCode": "MMT"}"""
    
        if st.button('Generate NGSI-LD data'):
            # st.session_state.entity_ngsild=generate_ngsi_ld(json.loads(selection_json))
            st.session_state.entity_ngsild=generate_ngsi_ld(selection)
        if st.session_state.entity_ngsild is not None:
            print(st.session_state.entity_ngsild)
            if st.session_state.entity_ngsild.id != 'urn:ngsi-ld:leather:empty':
                with st.popover("Show NGSI-LD JSON"):
                    # entity_ngsild is Entity type, to_json() return a string JSON 
                    st.markdown(json_to_markdown(json.loads(st.session_state.entity_ngsild.to_json())))

        if st.session_state.entity_ngsild is not None:    
             if st.session_state.entity_ngsild.id != 'urn:ngsi-ld:leather:empty':
                if st.button('Send data to CIRCOLOOS platform'):
                    print(st.session_state.entity_ngsild) 
                    # post_ngsi_to_cb_with_token needs a list of entities 
                    responses,info,error=utlis.post_ngsi_to_cb_with_token([st.session_state.entity_ngsild]) 
                    # print(responses,info,error) 
                    ui.alert_dialog(show=True, title="CIRCULOSS response", description=responses, confirm_label="OK", cancel_label="Cancel", key="alert_dialog1")
                    selection={}
                    
                    
    

    


if __name__ == "__main__":
    main()

    