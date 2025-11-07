./addDataOrion.sh ../circuloos-entities/plastic/washing-machine-tray/companies.json
./addDataOrion.sh ../circuloos-entities/plastic/washing-machine-tray/warehouse.json 
./addDataOrion.sh ../circuloos-entities/plastic/washing-machine-tray/washing_machine_tray_materials.json
./addDataOrion.sh ../circuloos-entities/plastic/washing-machine-tray/washing_machine_tray_components.json
./addDataOrion.sh ../circuloos-entities/plastic/washing-machine-tray/washing_machine_tray.json
#  generate the needed raw of the urn:ngsi-ld:ManufacturingMachine:washingMachineTray:001
python3 expand_entity.py "urn:ngsi-ld:ManufacturingMachine:washingMachineTray:001" --ngsi-ld-materials --output ../circuloos-entities/plastic/washing-machine-tray/material_totals_entity.json
./appendAttributesOrion.sh urn:ngsi-ld:ManufacturingMachine:washingMachineTray:001 ../circuloos-entities/plastic/washing-machine-tray/washing_machine_tray_materialTotals.json