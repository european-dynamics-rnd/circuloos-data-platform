import csv_ngsild_agent_utils as utlis
from ngsildclient import Client


NGSI_LD_CONTECT_BROKER_HOSTNAME="localhost"
NGSI_LD_CONTECT_BROKER_PORT=1026
ORION_LD_TENANT="circuloos_demo"
cilculoss_orion_ld_client=Client(hostname=NGSI_LD_CONTECT_BROKER_HOSTNAME ,port=NGSI_LD_CONTECT_BROKER_PORT, tenant=ORION_LD_TENANT)

# csv_file = 'leatherProducts.csv'
csv_file='../leather_board_outline/leather_outline.csv'
data=utlis.load_csv_files_to_dict(csv_file)
# print(data)
for entity_dict in data:
    print(entity_dict)
    entity_ngsild=utlis.generate_ngsild_entity(entity_dict)
    entity_ngsild.pprint()
    print(cilculoss_orion_ld_client.upsert(entity_ngsild))

    
