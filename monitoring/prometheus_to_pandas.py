import requests
import pandas as pd
from datetime import datetime, timedelta

# Prometheus query endpoint and query
prometheus_url = "http://bf-micocraft-server:9090"
# Metric to query
# query = 'orion_incomingTransactions'
query = 'ngsildRequests'

# Time range: last 24 hours
end_time = datetime.now()
start_time = end_time - timedelta(days=2)

# Convert times to Unix timestamp format
start = int(start_time.timestamp())
end = int(end_time.timestamp())

# Step (resolution) in seconds, e.g., 1 minute
# to be used to setup the prometheus alert
step = '60' 

# Construct the query
params = {
    'query': query,
    'start': start,
    'end': end,
    'step': step
}


# Send the request
response = requests.get(f"{prometheus_url}/api/v1/query_range", params=params)

# Handle the response
if response.status_code == 200:
    results = response.json()['data']['result']

    # Convert results to a format suitable for Pandas
    data = []
    for result in results:
        for value in result['values']:
            data.append({'timestamp': value[0], 'value': value[1], **result['metric']})

    # Create a Pandas DataFrame
    df = pd.DataFrame(data)

    # Convert timestamp to datetime and set as index
    df['timestamp'] = pd.to_datetime(df['timestamp'], unit='s')
    df.set_index('timestamp', inplace=True)
    df['value'] = pd.to_numeric(df['value'], errors='coerce')
    df['value_change'] = df['value'].diff() / 100
    df = df[['value', 'value_change']]

    print("DataFrame size: Rows =", df.shape[0], ", Columns =", df.shape[1])

    # print(df.head()) 
    print(df)
    average_value = df['value_change'].mean()
    # these is the inhouse trafic from docker etc 
    # put  
    print("Average value:", average_value)
    df.to_csv(query+'_prometheus.csv', index=True) 
    
else:
    print("Failed to retrieve data:", response.text)
