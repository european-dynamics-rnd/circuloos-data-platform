from flask import Flask, render_template, request, redirect, url_for, jsonify
import os
from werkzeug.utils import secure_filename
import os
import glob
import csv_ngsild_agent_utils as utlis
import pprint
import json
import requests
from requests import Request, Session
from datetime import datetime
import sys
import logging

app = Flask(__name__)
UPLOAD_FOLDER = 'uploaded_files'
# ALLOWED_EXTENSIONS = {'json','csv'}
ALLOWED_EXTENSIONS = {'csv'}
entity_ngsild_json_global= None

# Get logging level from environment variable or default to INFO
log_level = os.getenv("LOG_LEVEL", "INFO").upper()
numeric_level = getattr(logging, log_level, logging.INFO)
logging.basicConfig(level=numeric_level, format='%(asctime)s - %(levelname)s - %(message)s')



def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS
           
def generate_ngsi_ld_entities():
    # Your logic to generate NGSI-LD entities  
    config=utlis.get_config()
    lastest_csv= utlis.return_lastest_csv(UPLOAD_FOLDER,logging)
    data=utlis.load_csv_files_to_dict(lastest_csv,logging)
    entity_ngsild_json_str=""
    entity_ngsild_json=[]
    for entity_dict in data:
        entity_ngsild=utlis.generate_ngsild_entity(entity_dict,config['CONTEXT_JSON'])
        # entity_ngsild.to_json()
        entity_ngsild_json_str=entity_ngsild_json_str+'\n,'+ entity_ngsild.to_json( indent=4) #str(len(entity_ngsild_json))+": \n"+ 
        entity_ngsild_json.append(entity_ngsild)
    return entity_ngsild_json_str, entity_ngsild_json

@app.route('/')
def upload_form():
    return render_template('upload.html')

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return {'status': 'error', 'message': 'No file part'}
    file = request.files['file']
    if file.filename == '':
        return {'status': 'error', 'message': 'No selected file'}
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join(UPLOAD_FOLDER, filename))
        return {'status': 'success', 'message': 'File uploaded successfully'}
    else:
        return {'status': 'error', 'message': 'Invalid file type'}

# For button Generate NGSI-LD entities    
@app.route('/generate-ngsi-ld', methods=['POST'])
def handle_generate_ngsi_ld():
    global entity_ngsild_json_global
    try:
        entity_ngsild_json_str, entity_ngsild_json_global  = generate_ngsi_ld_entities()
        
    except Exception as e:
        logging.error(f"An error occurred: {e}")
        entity_ngsild_json_str=f"{e}. Please check if you have id and type"    
    # cleaning the local storage
    csv_files = glob.glob(os.path.join(UPLOAD_FOLDER, '*.csv'))
    for csv_file in csv_files:
        os.remove(csv_file)
    return render_template('upload.html', message=entity_ngsild_json_str)

# For button Generate NGSI-LD entities    
@app.route('/check-connectivity', methods=['POST'])
def handle_check_connectivity():
    
    responses,info,error=utlis.get_cb_info_with_token()
    
    app.logger.info(info)
    if len(str(error))>0:
        app.logger.error(error)
        
    return jsonify({'error': str(error), 'responses': responses})



# For button Post NGSI-LD entities to Orion-LD
@app.route('/post-ngsi-ld', methods=['POST'])
def handle_post_ngsi_ld():
    if entity_ngsild_json_global is None:
        responses="Please upload and push the button Generate NGSI-LD entities. Press Go back one"
        info="empty entity_ngsild_json_global"
        error="empty entity_ngsild_json_global"
    else:
        responses,info,error=utlis.post_ngsi_to_cb_with_token(entity_ngsild_json_global)

    app.logger.info(info)
    if len(str(error))>0:
        app.logger.error(error)
    # delete all csv files

    return responses


if __name__ == '__main__':
    config=utlis.get_config()
    port = config['CSV_AGENT_PORT']
    app.run(host='0.0.0.0', port=port)
