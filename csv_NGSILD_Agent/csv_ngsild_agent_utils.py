from ngsildclient import Entity
import csv
import glob
import json
import os
from datetime import datetime



def return_lastest_csv(UPLOAD_FOLDER):
    # Specify your folder path here
    # Get a list of all JSON files in the folder
    csv_files = glob.glob(os.path.join(UPLOAD_FOLDER, '*.csv'))

    # Sort files by modification time in descending order
    csv_files.sort(key=lambda x: os.path.getmtime(x), reverse=True)
    if csv_files:
        latest_csv_file = csv_files[0]
        print(f"Latest csv file: {latest_csv_file}")
        return latest_csv_file
    else:
        print("No csv files found in the folder.")
        csv_data = None
        return None
    return None

def load_csv_files_to_dict(csv_file):
    # Create an empty list to store the dictionaries
    data = []
    with open(csv_file, mode='r', encoding='utf-8') as file:
        # Read the first row to get the headers
        reader = csv.reader(file)
        headers = next(reader, None)
        # Check if the first two headers are 'id' and 'type'
        if headers[:2] == ['id', 'type']:
            # Reset the file pointer to the start of the file
            file.seek(0)
            csv_dict_reader = csv.DictReader(file, delimiter=',', quotechar='"')
            for row in csv_dict_reader:
                data.append(row)
        else:
            print("The first two headers are not 'id' and 'type'")
            return [] # empty_dict
    return data

def generate_ngsild_entity(entity):
    # entity['type']
    entity_ngsild = Entity(
        entity.pop('type',None),
        entity.pop('id',None),
        ctx=[
            "http://circuloos-ld-context/merge_data_model.jsonld",
        ],
    )
    keys = list(entity.keys())
    if "observedat" in keys:
        iso_date_str=entity.pop("observedat",None)
        keys.remove("observedat")
        #check if timeStamp is ISO8601
        try:
            date_obj = datetime.fromisoformat(iso_date_str)
        except ValueError:
            date_obj=datetime.utcnow()
    else:
        date_obj=datetime.utcnow()
    for key in keys:
        if  "_unitCode" not in key:
            value = entity.pop(key)
            if key+"_unitCode" in keys:
                unitCode= entity.pop(key+"_unitCode",None)
                entity_ngsild.prop(key,value, observedat=date_obj, unitcode=unitCode)
            else:
                entity_ngsild.prop(key,value, observedat=date_obj)
    # entity['a']='a'   # to test the error
    if len(entity) != 0:
        print(f"error should be empty:{len(entity)}")
    return entity_ngsild

def load_lastest_json_file(UPLOAD_FOLDER):
    # Specify your folder path here
    # Get a list of all JSON files in the folder
    json_files = glob.glob(os.path.join(UPLOAD_FOLDER, '*.json'))

    # Sort files by modification time in descending order
    json_files.sort(key=lambda x: os.path.getmtime(x), reverse=True)

    # Check if there are any JSON files in the folder
    if json_files:
        latest_json_file = json_files[0]
        print(f"Latest JSON file: {latest_json_file}")

        # Load the latest JSON file into a variable
        with open(latest_json_file, 'r') as file:
            json_data = json.load(file)
        print("JSON data loaded successfully.")
    else:
        print("No JSON files found in the folder.")
        json_data = None
    return json_data
