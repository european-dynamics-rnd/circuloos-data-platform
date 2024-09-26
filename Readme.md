# CIRCULOOS Platform
The CIRCULOOS Platform utilizes FIWARE components, designed to be implemented on factory premises or on the cloud. It compatible with the [NGSI-LD](https://www.etsi.org/deliver/etsi_gs/CIM/001_099/009/01.07.01_60/gs_cim009v010701p.pdf) (Next Generation Service Interfaces) specifications. This platform setup serves as a template, equipped with minimal configurations to facilitate a smooth startup. Utilizing [FIWARE generic enablers](https://github.com/FIWARE/catalogue). 

## Architecture 
The main components of the circuloos IoT LD platform are:
1. [Orion-LD](https://github.com/FIWARE/context.Orion-LD) as Context Broker.
2. [Mintaka](https://github.com/FIWARE/mintaka) as NGSI-LD temporal retrieval API ([OpenAPI Specifications](./commands_URL/miktakaOpenAPISpecs.yaml)).
3. [Keycloak](https://www.keycloak.org/) as single sign-on with identity and access management.
4. [Kong](https://github.com/FIWARE/kong-plugins-fiware) as PEP (Policy Enforcement Point) proxy for Orion-LD and Mintaka.


![CILCULOOS Platform Architecture](./CILCULOOS_demo.png)

# CILCULOOS Platform

In the [commands_URL](./commands_URL) you can find commands to interact with the CIRCULOOS Platform located on European Dynamics Server, circuloos-platform.eurodyn.com.
You **need** to change the centennial in the **partner_variables.txt** that was send to you by email, **PARTNER_USERNAME** and **PARTNER_PASSWORD**. If you have not received your partner credentials, please e-mail konstantinos.gombakisATeurodyn.com.

If you want to utilize the tools CSV to Orion-LD agent and Leather board outline to send data to the CIRCULOOS platform please use the .yml files inside their directories.


Moreover, a Postman collection of the same commands is [HERE](./commands_URL/ED%20CIRCULOOS%20Platform.postman_collection.json).
Please go throu the demo and then try to connect to the ED CIRCULOOS Platform.
To send **REAL data** from you pilot please chose a unique **NGSILD-Tenant** to ensure proper data separation form other partner data.

# Providing Pilot data to the CIRCULOOS Data platform

To provide/send data to the CIRCULOOS data platform you have 2 available options:
- To provide your data by sending it as a valid NGSI-LD JSON to the Orion-LD. With these option you have to implement an mechanism to receive the Authedication token from the CIRCULOOS Keycload and provide the token along side your NGSI-LD JSON
- Utilizing the NGSI-LD Federation scheme. With these scheme selected data received on your local Orion-LD will be forwarded to the CIRCULOOS Orion-LD. See [Readme_federation.md](./circuloos-registration-to-entities/Readme_federation.md) for more information.

# Demo 

The demo have can run on every Linux system. The following tools needs to be installed: ```docker-compose-plugin, curl, bash, jq``` 
jq is used for the formatting of the return json from Orion-LD and Mintaka.

The platform have been tested on the latest version of the docker compose (```docker compose version```) : Docker Compose version v2.29.7

## Docker
To run circuloos use: ```./service.sh start``` on the main folder. The first time will need to download all Docker images ~10minutes depending on internet speed. Then open another terminal to [continue](#demo).

The main docker-compose file(docker-compose.yml) include additional compose files for specific services.
1. temporal.yml. Service for Mintaka and TimescaleDB.
2. keycloak.yml. Service for Keycloak and Kong.
3. circuloos_custom_apps.yml The custom service to upload/transform csv to NGSI-LD JSON and send/POST to Orion-LD and leather board outline

**IMPORTANT** all commands can be found on commands folder

## Check Orion and Mintaka are online 
You can use the following commands:
1. ```./getOrionVersion.sh``` : To get the version of the Orion-LD
2. ```./getOrionVersionViaKong.sh``` : To get the version of the Orion-LD using KONG as PEP (Policy Enforcement Point) proxy
3. ```./getMintakaVersion.sh``` : To get the version of the Mintaka
4. ```./getMintakaVersionViaKong.sh``` : To get the version of the Mintaka using KONG as PEP (Policy Enforcement Point) proxy

## Add data to Orion-LD
A simple Indoor Enviromental Quality sensor measurements have been encoding used NGSI-LD JSON ([demo_1_ieq-001_15min.json](./ieq_sensor/demo_1_ieq-001_15min.json)). With the following commands you can send/POST the measurements to the Orion CB.
1. ```./addDataOrion.sh ../ieq_sensor/demo_1_ieq-001.json``` : Add data to the Orion-LD
2. ```./addDataOrionViaKong.sh ../ieq_sensor/demo_1_ieq-001_15min.json``` : Add data to the Orion-LD Orion-LD using KONG as PEP (Policy Enforcement Point) proxy **These will be used for external systems**
3. ```./addDataOrionViaKong.sh ../ieq_sensor/demo_1_ieq-001_30min.json```

## Get the data from Orion-LD
Orion-LD keeps only the latest measurement of each entity.
1. ```./getDataOrionSensors.sh``` : To get the last measurement of the urn:ngsi-ld:circuloos:demo_1:ieq-001. The property "observedAt" should  be "2024-01-11T10:30:07.446000Z"
2. ```./getDataOrionSensorsViaKong.sh``` : To get the last measurement of the urn:ngsi-ld:circuloos:demo_1:ieq-001 using KONG as PEP (Policy Enforcement Point) proxy

## Get the data from Miktana - historical 
1. ```./getDataMintaka.sh``` : To get the historical measurements of the urn:ngsi-ld:circuloos:demo_1:ieq-001.
2. ```./getDataMintakaViaKong.sh``` : Historical measurements of the urn:ngsi-ld:circuloos:demo_1:ieq-001 using KONG as PEP (Policy Enforcement Point) proxy


# CSV to Orion-LD agent
A custom agent have been created to transform a CSV to NGSI-LD entities and send/POST them to the Orion-LD.

1. Create the csv file with the data that you want to add to the Orion-LD. **IMPORTANT** the first 2 columns **MUST BE** id,type. See [csv_NGSILD_Agent/leatherProducts.csv](csv_NGSILD_Agent/leatherProducts.csv) for a csv file with 2 entities. To add timestamp for the data add a column "observedat" with the date time into a ISO8601 format ("2024-01-31T12:03:02Z"), otherwise the timestamp will be set to current date/time.
2. Go to http://localhost:5000, click on "Browre..." to select a csv file. Next click "Upload".
3. Click "Generate NGSI-LD entities". A JSON representation of the NGSI-LD of the csv entities will appear.
4. Click "Post NGSI-LD entities to Orion-LD". The created NGSI-LD JSON will be send to the Orion-LD. A message with the IDs of the send to the Orion-LD will appear. 
5. See the data send to the Orion-LD ```./getDataOrionSensors.sh leather```

## Send data to the CIRCULOOS CB 

In order to send the data to the official CIRCULOOS platform the file 'csv_NGSILD_Agent/circuloos-csv-ngsild-agent.yml' needs to be updated with the partner's username and passowrd.
1. Update csv_NGSILD_Agent/circuloos-csv-ngsild-agent.yml 
2. Run the ``` docker compose -f circuloos-csv-ngsild-agent.yml up ``` inside folder csv_NGSILD_Agent
3. Follow previous instructions 


# Leather board outline
## Irregular leather board  

A tool to calculate and transform the image of an irregular leather board to coordinates with the help of Aruco marker along side with the necessary metadata.
Print the aruco markers from the [pdf](./leather_board_outline/aruco_markers.pdf) and measure them. Update the configuration of the docker that you run ([local testing](./circuloos_custom_apps.yml) or [CIRCULOOS platform](./leather_board_outline/leather-board-outline-irregular.yml)) ```NUMBER_ARUCO_MARKERS``` with the number of markers that you are using and ```SIZE_IN_METERS_ARUCO_MARKERS``` the size of the printed markers in **meters**.
For the demo 2 aruco markers with dimensions of 0.045m (4.5cm) is used.

The leather/fabric **MUST** be photographed with a white background. Moreover there should be as flat as possible with no visible shadows. The aruco markers can be glued or taped on the surface and a piece of glass can be put on top of the leather/fabric.

**IMPORTANT** when you download/update (via git pull) rebuild the local docker images !!! ```./service.sh build``` or ```docker compose -f leather_board_outline/leather-board-outline-irregular.yml build```


### Send the data to the CIRCULOOS platform

1. Ensure that the platform for local development is down. Run ```./service.sh stop``` on the main directory
2. Edit the ```leather_board_outline/leather-board-outline-irregular.yml``` with the credentials that you have received. 
3. Run the docker compose: ```docker compose -f leather_board_outline/leather-board-outline-irregular.yml up```
4. Follow the instruction got as the local one (with ./service.sh start)

## Using the Leather board outline tool
1. Go to http://localhost:8501
2. Upload the image with the aruco markers and the leather board. For demo you can use the ```/leather_board_outline/imagesfabric_1_no_ruller.jpg```
3. Examine the generated outline
4. Fill all the necessary metadata/NGSI-LD properties required for the leather board. The id have been filled with a random name, please update it **BUT** it needs to start with  **urn:ngsi-ld:leather:**. If the color in not present on the list please use the option ```other colour``` and a color selector will apera to select the required colour 
5. Click ```Generate NGSI-LD JSON``` button. If any of the required data is not filled a error message will appear
6. _optional_ Click ```Show NGSI-LD JSON``` button to see the generated NGSI-LD JSON with all the data
6. _optional_ Click ```Download NGSI-LD JSON``` button to see the generated NGSI-LD JSON with all the data
7. _optional_ Click ```Check connectivity with CIRCULOOS platform``` to check the connectivity with the CIRCULOOS platform.
8. Click ```Send data to CIRCOLOOS platform``` button to send the NGSI-LD JSON to the local or CIRCULOOS platform. A popup message will inform you about the status of the operation

![screenshoot](./leather_board_outline/images/Screenshot_leather-board-outline-irregular.png)


## Rectangle leather board covering the entire image  
A tool to calculate and transform to coordinates the remaining part of a rectangle leather board/sheet for recycling. Need to know the dimensions of the rectangle leather board

1. Go to the http://localhost:8503
2. Set the outside dimensions (width, height) of the leather board.
3. Upload the image of the leather board. The removed/cut peaces **MUST** be with white colour. See folder [leather_board_outline/full_image_demonstrating](./leather_board_outline/full_image_demonstrating/) for examples.
4. The image, remaining, removed material will appear and statistics will be printed.
5. Click "Download Coordinates of remaining board" to download the coordinates. You can use them on with the previous tool to upload the data to the Orion-LD. See [leather_outline.csv](./leather_board_outline/leather_outline.csv) as example.

![screenshoot](./leather_board_outline/full_image_demonstrating/Screenshot_outline_full_image.png)





## Funding acknowledgement

<img src="./eu_flag.png" width="80" height="54" align="left" alt="EU logo" />
This project has received funding from the European Union’s “Horizon Europe” programme under grant agreement No. 101092295 (CIRCULOOS).
