from flask import Flask, request, render_template_string
import json

app = Flask(__name__)

# curl -X POST http://localhost:5055/notification_json -H "Content-Type: application/json" -d '{"key1": "value1", "key2": "value2"}' 
# curl -X POST http://recieve-notification-server:5055/notification_json -H "Content-Type: application/json" -d '{"key1": "value1", "key2": "value2"}' 

received_data = []

@app.route('/notification_json', methods=['POST'])
def notification_json():
    # Retrieve the JSON from the request
    json_data = request.json
    print("Received JSON:", json_data)
    
    received_data.append(json_data)

    # Append the data to the file
    with open("notification_data_recieved.json", "a") as file:
        # Convert the Python dictionary to a JSON formatted string
        json_string = json.dumps(json_data)
        # Write the string to the file with a newline character for separation
        file.write(json_string + "\n")
    
    return 'JSON received and saved', 200

@app.route('/view_data')
def view_data():
    # Render a simple HTML template with the data
    return render_template_string("""
        <html>
            <head>
                <title>Data Viewer</title>
            </head>
            <body>
                <h1>Received JSON Data</h1>
                {% for data in content %}
                    <pre>{{ data }}</pre>
                {% endfor %}
            </body>
        </html>
    """, content=received_data)


if __name__ == '__main__':
    app.run(debug=True, port=5055)