from flask import Flask, render_template, request, redirect, url_for, jsonify
import os
import glob
from werkzeug.utils import secure_filename
import csv_ngsild_agent_utils as utils


app = Flask(__name__)
UPLOAD_FOLDER = 'uploaded_files'
ALLOWED_EXTENSIONS = {'csv'}
entity_ngsild_json_global = None

os.makedirs(UPLOAD_FOLDER, exist_ok=True)
app.logger.setLevel(os.getenv("LOG_LEVEL", "INFO").upper())

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS
           
def generate_ngsi_ld_entities():
    """Generate NGSI-LD entities from the latest uploaded CSV."""
    config = utils.get_config()
    lastest_csv = utils.return_lastest_csv(UPLOAD_FOLDER, app.logger)
    data = utils.load_csv_files_to_dict(lastest_csv, app.logger)
    entity_ngsild_json = []
    json_fragments = []
    for entity_dict in data:
        entity_ngsild = utils.generate_ngsild_entity(entity_dict, config['CONTEXT_JSON'])
        json_fragments.append(entity_ngsild.to_json(indent=4))
        entity_ngsild_json.append(entity_ngsild)
    entity_ngsild_json_str = '\n,'.join(json_fragments)
    return entity_ngsild_json_str, entity_ngsild_json

@app.route('/')
def upload_form():
    return render_template('upload.html')

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'status': 'error', 'message': 'No file part'}), 400
    file = request.files['file']
    if file.filename == '':
        return jsonify({'status': 'error', 'message': 'No selected file'}), 400
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join(UPLOAD_FOLDER, filename))
        return jsonify({'status': 'success', 'message': 'File uploaded successfully'})
    else:
        return jsonify({'status': 'error', 'message': 'Invalid file type'}), 400

@app.route('/generate-ngsi-ld', methods=['POST'])
def handle_generate_ngsi_ld():
    global entity_ngsild_json_global
    try:
        entity_ngsild_json_str, entity_ngsild_json_global = generate_ngsi_ld_entities()
        # Only clean up CSV files after successful generation
        csv_files = glob.glob(os.path.join(UPLOAD_FOLDER, '*.csv'))
        for csv_file in csv_files:
            os.remove(csv_file)
    except Exception as e:
        app.logger.error(f"An error occurred: {e}")
        entity_ngsild_json_str = f"{e} Please check if you have id and type"
    return render_template('upload.html', message=entity_ngsild_json_str)

@app.route('/check-connectivity', methods=['POST'])
def handle_check_connectivity():
    error = "no errors"
    responses = ""
    try:
        responses = utils.get_cb_info_with_token(app.logger)
        app.logger.info(responses)
    except Exception as e:
        error_str = f"An error occurred: {e}"
        app.logger.error(error_str)
        error = error_str

    return jsonify({'error': str(error), 'responses': responses})



@app.route('/post-ngsi-ld', methods=['POST'])
def handle_post_ngsi_ld():
    if entity_ngsild_json_global is None:
        return jsonify({'status': 'error', 'message': 'Please upload your .csv file and push the button Generate NGSI-LD entities.'}), 400

    try:
        responses = utils.post_ngsi_to_cb_with_token(entity_ngsild_json_global, app.logger)
        app.logger.info(responses)
    except Exception as e:
        error_str = f"An error occurred: {e}"
        app.logger.error(error_str)
        return jsonify({'status': 'error', 'message': error_str}), 500

    return jsonify({'status': 'success', 'responses': responses})


if __name__ == '__main__':
    config = utils.get_config()
    port = config['CSV_AGENT_PORT']
    app.run(host='0.0.0.0', port=port)
