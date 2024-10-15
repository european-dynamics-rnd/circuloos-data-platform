Current version of CIRCULOOS is multi-tenant so there is a separation of each tenant data on the timescaleDB

For the testing will use 2 different type of Tenants:
- circuloos_ed_leather
- circuloos_ed_wood

# Add data to Orion-LD + timescaleDB
- run ```./service.sh start``` on the main directory
- run ```./import_data.sh``` to load data to the Orion-LD and timescaleDB. A series of scripts are run to load the data.

With the ```addDataOrion.sh``` a new entity can be created. If you need to update any property for an existing entity use: ```addDataOrion_replace.sh```

# See data from Orion-LD
From Orion-LD you can get the **LASTEST** values of each entity. With mintaka you get a temporal representation.

- run ```./getDataOrion.sh sensorID NGSILDTenant```

ie
    - ```./getDataOrion.sh urn:ngsi-ld:leather:apm5zima95 circuloos_ed_leather```
    - ```./getDataOrion.sh urn:ngsi-ld:leather:df4i9d circuloos_ed_leather```
    - ```./getDataOrion.sh urn:ngsi-ld:wood:asde43 circuloos_ed_wood```

# Get all entities of a specific NGSILD-Tenant

Run ```./queryOrionSensors.sh NGSILDTenant``` to get all entities of the specific Tennant

- ```./queryOrionSensors.sh circuloos_ed_leather```
- ```./queryOrionSensors.sh circuloos_ed_wood```
# See data via Temporal API/mintaka

- run ```./getDataMintaka.sh NGSI-LD_entity_id NGSILDTenant```

ie
    - ```./getDataMintaka.sh urn:ngsi-ld:leather:apm5zima95 circuloos_ed_leather```
    - ```./getDataMintaka.sh urn:ngsi-ld:leather:df4i9d circuloos_ed_leather```
    - ```./getDataMintaka.sh urn:ngsi-ld:wood:asde43 circuloos_ed_wood```

## When a product is sold from RAMP marketplace
When a product is sold to new company RAMP will need to generate a json payload like __dumy_data_ramp/json/leather_apm5zima95_sell_to_company_002.json__ and POST it to the CIRCULOOS Orion-LD on __/ngsi-ld/v1/entityOperations/update?options=replace__.
See examples with: addDataOrion_replace.sh .

## see timescaleDB with dbeaver
dbeaver: localhost:8978 

Add new database-> PostGresSQL
- IP: circuloos-timescale-db:5432
- Username:circuloos
- password:B3cXhx3h63P6fn5
On Database List-> Show all database

Each different tenant will generate a different database with naming convention: orion_+NGSILD-Tenant ie orion_circuloos_leather for NGSILD-Tenant: circuloos_leather
- On public.entities are stored all the entities and their update process
- On public.attributes is stored the actual values/properties of each entity
