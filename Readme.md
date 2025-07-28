# CIRCULOOS Platform
The CIRCULOOS Platform utilizes FIWARE components, designed to be implemented on factory premises or on the cloud. It compatible with the [NGSI-LD](https://www.etsi.org/deliver/etsi_gs/CIM/001_099/009/01.07.01_60/gs_cim009v010701p.pdf) (Next Generation Service Interfaces) specifications. This platform setup serves as a template, equipped with minimal configurations to facilitate a smooth startup. Utilizing [FIWARE generic enablers](https://github.com/FIWARE/catalogue). 

## Architecture 
The main components of the circuloos IoT LD platform are:

1. **[Orion-LD](https://github.com/FIWARE/context.Orion-LD)**
   - Role: Context Broker for NGSI-LD entity management
   - Function: Real-time data storage and retrieval

2. **[Mintaka](https://github.com/FIWARE/mintaka)**
   - Role: NGSI-LD temporal retrieval API
   - Function: Historical data queries and time-series analysis
   - Documentation: [OpenAPI Specifications](./commands_URL/miktakaOpenAPISpecs.yaml)

3. **[Keycloak](https://www.keycloak.org/)**
   - Role: Identity and Access Management (IAM)
   - Function: Single sign-on authentication and authorization

4. **[Kong](https://github.com/FIWARE/kong-plugins-fiware)** as API Proxy
   - Role: Policy Enforcement Point (PEP) proxy
   - Function: API gateway for Orion-LD and Mintaka access control

![CILCULOOS Platform Architecture](./CILCULOOS_demo.png)

## Integration Guide

### Prerequisites

- Docker and Docker Compose installed
- Linux environment (or WSL/VM for Windows users)

**ONLY** when you want to send data to the CIRCULOOS platform
- Valid partner credentials (delivered via secure email) 


### Authentication Configuration

1. **Credential Setup**
   - Locate `partner_variables.txt` from your integration package
   - Configure required parameters:
     - `PARTNER_USERNAME`: Assigned partner username
     - `PARTNER_PASSWORD`: Assigned partner password
     - **Centennial value**: Update as specified in credentials

2. **Missing Credentials**
   - Contact: `konstantinos.gombakis@eurodyn.com`
   - Include organization name and use case in request

### API Reference

All platform interaction commands are available in [`commands_URL`](./commands_URL) directory.
For interacting with **YOUR** local the same commands are available in [`commands`](./commands) directory.

**Postman Collection**: [`ED CIRCULOOS Platform.postman_collection.json`](./commands_URL/ED%20CIRCULOOS%20Platform.postman_collection.json)

## Data Integration Methods

To provide/send data to the CIRCULOOS data platform you have 2 available methods:

### Method 1: Direct NGSI-LD Submission
Send valid NGSI-LD JSON directly to Orion-LD with proper authentication tokens from Keycloak.

### Method 2: NGSI-LD Federation
Configure local Orion-LD to forward selected data to CIRCULOOS Orion-LD automatically.
- **Documentation**: [Readme_federation.md](./circuloos-registration-to-entities/Readme_federation.md)

### Production Data Deployment

**Tenant Configuration**: Select a unique `NGSILD-Tenant` identifier to ensure data isolation between partner organizations.

## Local Development Environment

### System Requirements

**Required Tools:**
- `docker-compose`
- `curl`
- `bash`
- `jq` (for JSON formatting)

**Installation References:**
- [Docker Compose Official Documentation](https://docs.docker.com/compose/install/linux/)
- [Rootless Docker Setup](https://docs.docker.com/engine/install/linux-postinstall/)

### Windows Development Setup

**Option 1: Virtual Machine**
- Install [VirtualBox](https://www.virtualbox.org/)
- Deploy latest [Ubuntu LTS](https://ubuntu.com/download/desktop)

**Option 2: WSL (Windows Subsystem for Linux)**
```bash
wsl --install --distribution Ubuntu
```
Then install [Docker](https://www.docker.com/)

### Local Platform Deployment

1. **Clone Repository**
   ```bash
   git clone [repository-url]
   cd circuloos-platform
   ```

2. **Start Platform**
   ```bash
   ./service.sh start
   ```
   *Initial startup downloads Docker images (~10 minutes depending on connection)*

3. **Verify Services**
   Open new terminal and proceed to testing commands

### Docker Compose Architecture

**Main Configuration**: `docker-compose.yml`

**Additional Service Files:**
- `temporal.yml`: Mintaka and TimescaleDB services
- `keycloak.yml`: Keycloak and Kong services  
- `circuloos_custom_apps.yml`: CSV transformation and leather board outline tools

## Platform Verification

### Service Health Checks

Navigate to commands directory:
```bash
cd commands
```

**Orion-LD Status:**
- `./getOrionVersion.sh`: Direct Orion-LD version check
- `./getOrionVersionViaKong.sh`: Orion-LD via Kong proxy (production method)

**Mintaka Status:**
- `./getMintakaVersion.sh`: Direct Mintaka version check
- `./getMintakaVersionViaKong.sh`: Mintaka via Kong proxy (production method)

### Data Operations Testing

**Data Ingestion:**
A simple Indoor Enviromental Quality sensor measurements have been encoding used NGSI-LD JSON ([demo_1_ieq-001_15min.json](./ieq_sensor/demo_1_ieq-001_15min.json)). With the following commands you can send/POST the measurements to the Orion CB.

- `./addDataOrion.sh ../ieq_sensor/demo_1_ieq-001.json`: Direct data upload
- `./addDataOrionViaKong.sh ../ieq_sensor/demo_1_ieq-001_15min.json`: Production method via Kong
- `./addDataOrionViaKong.sh ../ieq_sensor/demo_1_ieq-001_30min.json`: Additional test data

**Current Data Retrieval:**
- `./getDataOrionSensors.sh`: Latest measurement retrieval
- `./getDataOrionSensorsViaKong.sh`: Production method via Kong

**Historical Data Retrieval:**
- `./getDataMintaka.sh`: Historical data from Mintaka
- `./getDataMintakaViaKong.sh`: Production method via Kong


## Data Transformation Tools

# CSV to Orion-LD agent
**Purpose**: Transform CSV data into NGSI-LD entities and upload to Orion-LD

A custom agent have been created to transform a CSV to NGSI-LD entities and send/POST them to the Orion-LD.

1. Create the csv file with the data that you want to add to the Orion-LD. **IMPORTANT** the first 2 columns **MUST BE** id,type. See [csv_NGSILD_Agent/leatherProducts.csv](csv_NGSILD_Agent/leatherProducts.csv) for a csv file with 2 entities. To add timestamp for the data add a column "observedat" with the date time into a ISO8601 format ("2024-01-31T12:03:02Z"), otherwise the timestamp will be set to current date/time.
2. Go to http://localhost:5000, click on "Browse..." to select a csv file. Next click "Upload".
3. Click "Generate NGSI-LD entities". A JSON representation of the NGSI-LD of the csv entities will appear.
4. Click "Post NGSI-LD entities to Orion-LD". The created NGSI-LD JSON will be send to the Orion-LD. A message with the IDs of the send to the Orion-LD will appear. 
5. See the data send to the Orion-LD ```./getDataOrionSensors.sh leather```

## Send data to the CIRCULOOS data platform 

In order to send the data to the official CIRCULOOS platform the file 'csv_NGSILD_Agent/circuloos-csv-ngsild-agent.yml' needs to be updated with the partner's username and passowrd.
1. Stop any running CIRCULOOS dockers, by running ```./service.sh stop```
2. Update csv_NGSILD_Agent/circuloos-csv-ngsild-agent.yml 
3. Run the ``` docker compose -f circuloos-csv-ngsild-agent.yml up ``` inside folder csv_NGSILD_Agent
4. Follow previous instructions 


# Leather board outline
## Irregular leather board  
**Purpose**: Calculate coordinates from irregular leather board images using ArUco markers

A tool to calculate and transform the image of an irregular leather board to coordinates with the help of Aruco marker along side with the necessary metadata.
### Physical setup for taking the photo
Print the aruco markers from the [pdf](./leather_board_outline/aruco_markers.pdf) and measure them. Then, update the configuration of the docker that you run ([local testing](./circuloos_custom_apps.yml) or [CIRCULOOS platform](./leather_board_outline/leather-board-outline-irregular.yml)) ```NUMBER_ARUCO_MARKERS``` with the number of markers that you are using and ```SIZE_IN_METERS_ARUCO_MARKERS``` the size of the printed markers in **meters**.
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


## Troubleshooting

### Common Issues

**Docker Image Updates:**
After repository updates, rebuild local images:
```bash
./service.sh build
# or
docker compose -f [specific-compose-file].yml build
```

**Service Connectivity:**
Verify all services are running and accessible before proceeding with data operations.

**Data Upload Failures:**
- Verify credentials configuration
- Check tenant naming conventions
- Ensure NGSI-LD JSON validity

## Support

**Technical Contact**: `konstantinos.gombakis@eurodyn.com`

**Support Request Information:**
- Organization name
- Tenant identifier (if applicable)
- Error messages and logs
- Reproduction steps



## Funding acknowledgement

<img src="./eu_flag.png" width="80" height="54" align="left" alt="EU logo" />
This project has received funding from the European Union’s “Horizon Europe” programme under grant agreement No. 101092295 (CIRCULOOS).
