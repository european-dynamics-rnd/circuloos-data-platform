# CIRCULOOS Platform
The CIRCULOOS Platform utilizes FIWARE compoments, designed to be implemented on factory premises or on the cloud. It compatible with the [NGSI-LD](https://www.etsi.org/deliver/etsi_gs/CIM/001_099/009/01.07.01_60/gs_cim009v010701p.pdf) (Next Generation Service Interfaces) specifications. This platform setup serves as a template, equipped with minimal configurations to facilitate a smooth startup. Utilizing [FIWARE generic enablers](https://github.com/FIWARE/catalogue).

## Architecture 
The main components of the circuloos IoT LD platform are:
1. [Orion-LD](https://github.com/FIWARE/context.Orion-LD) as Context Broker.
2. [Mintaka](https://github.com/FIWARE/mintaka) as NGSI-LD temporal retrieval API.
3. [Keycloak](https://www.keycloak.org/) as single sign-on with identity and access management.
4. [Kong](https://github.com/FIWARE/kong-plugins-fiware) as PEP (Policy Enforcement Point) proxy for Orion-LD and Mintaka.


![CILCULOOS Platform Architecture](./CILCULOOS_demo.png)

# CILCULOOS Platform

In the [commands_URL](./commands_URL) you can find commands to interact with the CIRCULOOS Platform located on European Dynamics Server, circuloos-platform.eurodyn.com.\
You **need** to change the centennial in the **partner_variables.txt** that was send to you by email, **PARTNER_USERNAME** and **PARTNER_PASSWORD**. If you have not received your partner credentials, please e-mail konstantinos.gombakisATeurodyn.com \
Moreover, a Postman collection of the same commands is [HERE](./commands_URL/ED CIRCULOOS Platform.postman_collection.json)\
Please go throu the demo and then try to connect to the ED CIRCULOOS Platform.\
To send **REAL data** from you pilot please chose a unique **NGSILD-Tenant** to ensure proper data separation form other partner data.


# Demo 

The demo have can run on every Linux system. The following tools needs to be installed: ```docker-compose, curl, bash, jq``` 
jq is used for the formatting of the return json from Orion-LD and Mintaka.

## Docker
To run circuloos use: ```./service start``` on the main folder. The first time will need to download all Docker images ~10minutes depending on internet speed. Then open another terminal to [continue](#demo).

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

# Leather board outline
A simple tool to calculate and transform to coordinates the remaining part of the leather board/sheet for recycling. 

1. Go to the http://localhost:8501
2. Set the outside dimensions (width, height) of the leather board.
3. Upload the image of the leather board. The removed/cut peaces **MUST** be with white colour. See folder [leather_board_outline](./leather_board_outline) for examples.
4. The image, remaining, removed material will appear and statistics will be printed.
5. Click "Download Coordinates of remaining board" to download the coordinates. You can use them on with the previous tool to upload the data to the Orion-LD. See [leather_outline.csv](./leather_board_outline/leather_outline.csv) as example.

![screenshoot](./leather_board_outline/Screenshot_outline.png)

## Funding acknowledgement

<img src=" data:image/jpeg;base64,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" width="80" height="54" align="left" alt="EU logo" />
This project has received funding from the European Union’s “Horizon Europe” programme under grant agreement No. 101092295 (CIRCULOOS).
