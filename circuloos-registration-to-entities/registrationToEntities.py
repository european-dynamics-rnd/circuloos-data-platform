from flask import Flask, request, Response, stream_with_context
import requests

from http.server import BaseHTTPRequestHandler, HTTPServer
import os
import re
import logging
import json

log_level = os.getenv('LOG_LEVEL', 'ERROR').upper()
# Configure logging
logging.basicConfig(
    level=getattr(logging, log_level, logging.ERROR),
    format='%(asctime)s- %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

DEFAULT_CONTEXT=os.getenv('DEFAULT_CONTEXT','http://circuloos-ld-context/circuloos-context.jsonld')
HOST =os.getenv('PROXY_HOST','0.0.0.0')
PORT =os.getenv('PROXY_PORT',8888) 
HTTP_SERVICES_BROKER_URL=os.getenv('HTTP_SERVICES_BROKER_URL','https://circuloos-platform.eurodyn.com/kong/keycloak-orion/ngsi-ld/v1/entityOperations/upsert') 

USERNAME=os.getenv('USERNAME',"")
PASSWORD=os.getenv('PASSWORD',"")
CLIENT_SECRET=os.getenv('CLIENT_SECRET',"")

# GENERAL_TENANT=test_federation

def get_token_circuloos():

    KEYCLOCK_URL = "https://circuloos-platform.eurodyn.com/idm/realms/fiware-server/protocol/openid-connect/token"

    payload = f'username={USERNAME}&password={PASSWORD}&grant_type=password&client_id=orion-pep&client_secret={CLIENT_SECRET}'
    headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
    }
    try:
        response = requests.request("POST", KEYCLOCK_URL, headers=headers, data=payload)
        response.raise_for_status()
        # Log the response for debugging
        logger.info('Response status code: %s', response.status_code)
        logger.debug('Response body: %s', response.text)
    except requests.exceptions.RequestException as req_err:
        response_json['access_token']=""
        logger.error(f'Request error occurred: {req_err}')
    except Exception as err:
        response_json['access_token']=""
        logger.error(f'An unexpected error occurred: {err}')
    else:
        # Process the response if needed
        logger.info('Request was successful.')
        print(response.json())  # Example of processing the res
        response_json=response.json()
        logger.debug(response_json['access_token'])
        
    return response_json['access_token']

def extract_data_inside_angle_brackets(text):
    """
    Extract the data inside angle brackets <> from the given text.
    If no data is found, return an empty string.
    
    :param text: The input string containing the angle brackets
    :return: A string found inside the angle brackets, or an empty string if not found
    """
    pattern = r'<(.*?)>'
    matches = re.findall(pattern, text)
    return matches[0] if matches else ""
    
def fromRegistrationToEntity(registration_json):
    
    if 'data' in registration_json:
        # if not '@context' in ['data'][0]:
        #     registration_json['data'][0]['@context']=CONTEXT
        return registration_json['data'][0]
    else:
        logger.error("empty entity from registration",registration_json)
        return -1


app = Flask(__name__)

@app.route('/proxy', methods=[ 'POST'])
def proxy():
    # Ensure the URL has a scheme
    logger.info(request)
    # Get the method of the request
    method = request.method

    # Get the headers from the original request
    headers = {key: value for (key, value) in request.headers.items() if key not in ['Host', 'Content-Length','User-Agent']}
    # headers['Link'] <http://ld-context/ed-context.jsonld>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"
    context=extract_data_inside_angle_brackets(headers['Link'])
    if context == "":
        context=DEFAULT_CONTEXT
        headers.pop('Link', None)
        
    # Get the data from the original request
    data = request.json
    # data=json.loads(data)
    data=fromRegistrationToEntity(data)
    data=f"[{json.dumps(data)}]"
    
    token=get_token_circuloos()
    headers["Authorization"] = "Bearer " + token
    
    
    url=HTTP_SERVICES_BROKER_URL
    logger.info(f"Sending request:")
    logger.info(f"  Method: {method}")
    logger.info(f"  URL: {url}")
    logger.info(f"  Headers: {headers}")
    logger.info(f"  data: {data}")

    try:
        # Make the request to the target server
        resp = requests.request(
            method=method,
            url=url,
            headers=headers,
            data=data,
            stream=True,
            allow_redirects=False
        )
        # Log the response details
        logger.info(f"Received response:")
        logger.info(f"  Status: {resp.status_code}")
        logger.info(f"  Headers: {dict(resp.headers)}")
        # Create a response object
        proxied_response = Response(
            stream_with_context(resp.iter_content(chunk_size=8192)),
            content_type=resp.headers.get('Content-Type'),
            status=resp.status_code
        )

        # Add headers from the proxied response
        for header, value in resp.headers.items():
            if header.lower() not in ('transfer-encoding', 'content-encoding'):
                proxied_response.headers[header] = value

        return proxied_response

    except requests.RequestException as e:
        logger.error(f"Error forwarding request: {str(e)}")
        return f"Error forwarding request: {str(e)}", 500
    
if __name__ == '__main__':
    app.run(host=HOST, port=PORT, debug=True)
