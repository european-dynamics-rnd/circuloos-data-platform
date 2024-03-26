from flask import Flask, render_template, request, redirect, url_for
from ngsildclient import Client
import os
from werkzeug.utils import secure_filename
import os
import csv_ngsild_agent_utils as utlis
import pprint
import json

app = Flask(__name__)
UPLOAD_FOLDER = 'uploaded_files'
# ALLOWED_EXTENSIONS = {'json','csv'}
ALLOWED_EXTENSIONS = {'csv'}
entity_ngsild_json_global= None
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# NGSI_LD_CONTECT_BROKER_HOSTNAME="localhost"
# NGSI_LD_CONTECT_BROKER_PORT=1026
# ORION_LD_TENANT="circuloos_demo"
# CONTEXT_JSON="http://circuloos-ld-context/circuloos-context.jsonld"

NGSI_LD_CONTECT_BROKER_HOSTNAME=os.environ['NGSI_LD_CONTECT_BROKER_HOSTNAME']
NGSI_LD_CONTECT_BROKER_PORT=int(os.environ['NGSI_LD_CONTECT_BROKER_PORT'])
ORION_LD_TENANT=os.environ['ORION_LD_TENANT']
CONTEXT_JSON=os.environ['CONTEXT_JSON']

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS
           
def generate_ngsi_ld_entities():
    # Your logic to generate NGSI-LD entities  
    lastest_csv= utlis.return_lastest_csv(UPLOAD_FOLDER)
    data=utlis.load_csv_files_to_dict(lastest_csv)
    entity_ngsild_json_str=""
    entity_ngsild_json=[]
    for entity_dict in data:
        entity_ngsild=utlis.generate_ngsild_entity(entity_dict,CONTEXT_JSON)
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
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        return {'status': 'success', 'message': 'File uploaded successfully'}
    else:
        return {'status': 'error', 'message': 'Invalid file type'}

# For button Generate NGSI-LD entities    
@app.route('/generate-ngsi-ld', methods=['POST'])
def handle_generate_ngsi_ld():
    global entity_ngsild_json_global
    entity_ngsild_json_str, entity_ngsild_json_global  = generate_ngsi_ld_entities()
    return render_template('upload.html', message=entity_ngsild_json_str)

# For button Post NGSI-LD entities to Orion-LD
@app.route('/post-ngsi-ld', methods=['POST'])
def handle_post_ngsi_ld():
    cilculoss_orion_ld_client=Client(hostname=NGSI_LD_CONTECT_BROKER_HOSTNAME ,port=NGSI_LD_CONTECT_BROKER_PORT, tenant=ORION_LD_TENANT)
    responses=[]
    for ngsi_ld_json in entity_ngsild_json_global:
        response=cilculoss_orion_ld_client.upsert(ngsi_ld_json)
        responses.append(f"Id: {ngsi_ld_json['id']} uploaded to Orion-LD: {response}")
    return responses


if __name__ == '__main__':
    port = int(os.environ.get('CSV_AGENT_PORT', 5000))
    app.run(debug=True, host='0.0.0.0', port=port)
