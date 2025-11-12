// ========================================
// CIRCULOOS Plastic Manufacturing - Neo4j Graph Database (SIMPLIFIED)
// Single Component Example: siphon
// ========================================

// Clear existing data (optional)
// MATCH (n) DETACH DELETE n;

// ========================================
// 1. CREATE MATERIAL
// ========================================

CREATE (mat1:Material {
  id: 'urn:ngsi-ld:Material:PP:001',
  name: 'PP',
  type: 'Material',
  specification: 'ISOFIL HK 30 TFH2 BL2092',
  stockLevel: 1.2,
  unitCode: 'KGM',
  carbonFootprint: 1.8,
  carbonFootprintUnit: 'KG_CO2_PER_KG',
  totalCO2: 0.0022,
  totalCO2Unit: 'tCO2'
});

// ========================================
// CREATE SCRAP MATERIAL (for circular economy)
// ========================================

CREATE (scrap1:Material {
  id: 'urn:ngsi-ld:Material:ScrapPP50:001',
  name: 'Scrap PP',
  type: 'Material',
  materialType: 'Scrap',
  specification: 'Recycled plastic from injection molding',
  stockLevel: 0.15,
  unitCode: 'KGM',
  recyclable: true,
  carbonFootprint: 0.4,
  carbonFootprintUnit: 'KG_CO2_PER_KG',
  totalCO2: 0.00006,
  totalCO2Unit: 'tCO2',
  co2Saved: 0.00021,
  co2SavedUnit: 'tCO2',
  co2SavedDescription: 'CO2 saved by recycling vs virgin plastic'
});

// ========================================
// 2. CREATE COMPANY (Manufacturer)
// ========================================

CREATE (comp1:Company {
  id: 'urn:ngsi-ld:Company:thermolympic',
  name: 'Thermolympic',
  type: 'Company',
  description: 'Plastic injection molding company',
  category: ['Manufacturing', 'Plastics']
});

// ========================================
// 3. CREATE COMPANY (Suppliers)
// ========================================

CREATE (comp2:Company {
  id: 'urn:ngsi-ld:Company:Lollo',
  name: 'Lollo',
  type: 'Company',
  description: 'Supplier of raw plastic materials',
  category: ['Supplier', 'Raw Plastics']
});

CREATE (comp3:Company {
  id: 'urn:ngsi-ld:Company:iberoplast',
  name: 'IberoPlast Supplies',
  type: 'Company',
  description: 'Spanish supplier of raw plastic materials',
  category: ['Supplier', 'Raw Plastics']
});

CREATE (comp4:Company {
  id: 'urn:ngsi-ld:Company:replastauto',
  name: 'RePlAstauto',
  type: 'Company',
  description: 'Plastic injection molding and recycled plastic company',
  category: ['Supplier','Manufacturing', 'Recycled Plastics']
});

CREATE (comp5:Company {
  id: 'urn:ngsi-ld:Company:circuprint',
  name: 'Circuprint',
  type: 'Company',
  description: '3D printing manufacturer using recycled materials',
  category: ['Manufacturing', '3D Printing']
});

// ========================================
// 4. CREATE WAREHOUSE
// ========================================

CREATE (wh1:Warehouse {
  id: 'urn:ngsi-ld:Warehouse:001',
  name: 'Warehouse 001',
  type: 'Warehouse'
});

// ========================================
// 5. CREATE INJECTION MOLDING MACHINE
// ========================================

CREATE (machine1:InjectionMoldingMachine {
  id: 'urn:ngsi-ld:InjectionMoldingMachine:001',
  name: 'Injection Molding Machine #1',
  type: 'InjectionMoldingMachine',
  manufacturer: 'Engel',
  model: 'e-victory 200/80',
  clampingForce: 200,
  clampingForceUnit: 'TON',
  injectionVolume: 290,
  injectionVolumeUnit: 'CM3',
  energyConsumptionPerCycle: 0.055,
  energyConsumptionUnit: 'KWH',
  cycleTime: 45,
  cycleTimeUnit: 'SECONDS',
  status: 'operational',
  operatingHours: 45230
});

// ========================================
// 6. CREATE COMPONENT (siphon)
// ========================================

CREATE (comp_siphon:ManufacturingComponent {
  id: 'urn:ngsi-ld:ManufacturingComponent:Siphon:001',
  name: 'siphon',
  type: 'ManufacturingComponent',
  weight: 0.10,
  weightUnit: 'KGM',
  stockLevel: 10,
  lastTimeUsed: '2025-10-20T10:00:00Z'
});

// ========================================
// 6b. CREATE 3D PRINTER
// ========================================

CREATE (printer1:ThreeDPrinter {
  id: 'urn:ngsi-ld:ThreeDPrinter:001',
  name: '3D Printer #1',
  type: 'ThreeDPrinter',
  manufacturer: 'Prusa',
  model: 'XL Multi-Tool',
  buildVolume: '360x360x360',
  buildVolumeUnit: 'MM',
  nozzleTemperature: 250,
  temperatureUnit: 'CELSIUS',
  printSpeed: 200,
  printSpeedUnit: 'MM/S',
  layerHeight: 0.2,
  layerHeightUnit: 'MM',
  status: 'operational',
  operatingHours: 1250
});

// ========================================
// 6c. CREATE COMPONENT (Chair)
// ========================================

CREATE (comp_chair:ManufacturingComponent {
  id: 'urn:ngsi-ld:ManufacturingComponent:Chair:001',
  name: 'Chair',
  type: 'ManufacturingComponent',
  weight: 2.5,
  weightUnit: 'KGM',
  stockLevel: 5,
  lastTimeUsed: '2025-11-01T10:00:00Z',
  description: '3D printed chair from recycled materials'
});



// ========================================
// 8. CREATE RELATIONSHIPS
// ========================================

// Material stored in Warehouse
MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP:001'})
MATCH (w:Warehouse {id: 'urn:ngsi-ld:Warehouse:001'})
CREATE (m)-[:STORED_IN]->(w);

// Material supplied by Company
MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP:001'})
MATCH (s:Company {id: 'urn:ngsi-ld:Company:rawplasticsa'})
CREATE (m)-[:SUPPLIED_BY {
  priority: 1,
  transportDistance: 350,
  transportDistanceUnit: 'KM',
  co2Transport: 0.000042,
  co2TransportUnit: 'tCO2',
  co2TransportDescription: 'CO2 from truck transport (0.12 kg CO2/km)'
}]->(s);

MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP:001'})
MATCH (s:Company {id: 'urn:ngsi-ld:Company:iberoplast'})
CREATE (m)-[:SUPPLIED_BY {
  priority: 2,
  transportDistance: 650,
  transportDistanceUnit: 'KM',
  co2Transport: 0.000078,
  co2TransportUnit: 'tCO2',
  co2TransportDescription: 'CO2 from truck transport (0.12 kg CO2/km)'
}]->(s);

// Machine owned by Company
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine:001'})
MATCH (comp:Company {id: 'urn:ngsi-ld:Company:thermolympic'})
CREATE (machine)-[:OWNED_BY]->(comp);

// Machine located in Warehouse
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine:001'})
MATCH (wh:Warehouse {id: 'urn:ngsi-ld:Warehouse:001'})
CREATE (machine)-[:LOCATED_IN]->(wh);

// Machine processes Material
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine:001'})
MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP:001'})
CREATE (machine)-[:PROCESSES_MATERIAL]->(m);

// Machine manufactures Component
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine:001'})
MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon:001  '})
CREATE (machine)-[:MANUFACTURES {
  moldingCycles: 2,
  moldingCycleTime: 45,
  energyConsumption: 0.11,
  energyUnit: 'KWH',
  setupTime: 15,
  totalProductionTime: 105,
  co2Emissions: 0.000055,
  co2EmissionsUnit: 'tCO2',
  co2EmissionsDescription: 'CO2 from energy use (0.5 kg CO2/kWh)'
}]->(c);

// Component has Material
MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon:001  '})
MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP:001'})
CREATE (c)-[:HAS_MATERIAL {quantity: 0.10, unit: 'KGM'}]->(m);

// Component stored in Warehouse
MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon:001  '})
MATCH (w:Warehouse {id: 'urn:ngsi-ld:Warehouse:001'})
CREATE (c)-[:STORED_IN]->(w);

// Component produced by Company
MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon:001  '})
MATCH (comp:Company {id: 'urn:ngsi-ld:Company:thermolympic'})
CREATE (c)-[:PRODUCED_BY]->(comp);

// ========================================
// CIRCULAR ECONOMY - Scrap Material Loop
// ========================================

// Machine produces Scrap Material
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine:001'})
MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP50:001'})
CREATE (machine)-[:PRODUCES_SCRAP {
  percentage: 5,
  amount: 0.005,
  unit: 'KGM',
  description: 'Scrap from molding process'
}]->(scrap);

// Scrap Material returned to Supplier for recycling
MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP50:001'})
MATCH (supplier:Company {id: 'urn:ngsi-ld:Company:rawplasticsa'})
CREATE (scrap)-[:RETURNED_TO {
  forRecycling: true,
  creditPerKg: 0.50,
  description: 'Circular economy - scrap returned for recycling'
}]->(supplier);

// Scrap Material also sent to replastauto for recycling
MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP50:001'})
MATCH (replastauto:Company {id: 'urn:ngsi-ld:Company:replastauto'})
CREATE (scrap)-[:RETURNED_TO {
  forRecycling: true,
  creditPerKg: 0.60,
  description: 'Specialized recycling for 3D printing filament'
}]->(replastauto);

// Scrap stored in Warehouse before return
MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP50:001'})
MATCH (wh:Warehouse {id: 'urn:ngsi-ld:Warehouse:001'})
CREATE (scrap)-[:STORED_IN]->(wh);

// ========================================
// 3D PRINTING - Chair Production
// ========================================

// 3D Printer owned by Circuprint
MATCH (printer:ThreeDPrinter {id: 'urn:ngsi-ld:ThreeDPrinter:001'})
MATCH (circuprint:Company {id: 'urn:ngsi-ld:Company:circuprint'})
CREATE (printer)-[:OWNED_BY]->(circuprint);

// 3D Printer located in Warehouse
MATCH (printer:ThreeDPrinter {id: 'urn:ngsi-ld:ThreeDPrinter:001'})
MATCH (wh:Warehouse {id: 'urn:ngsi-ld:Warehouse:001'})
CREATE (printer)-[:LOCATED_IN]->(wh);

// 3D Printer processes Scrap Material (from replastauto)
MATCH (printer:ThreeDPrinter {id: 'urn:ngsi-ld:ThreeDPrinter:001'})
MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP50:001'})
CREATE (printer)-[:PROCESSES_MATERIAL {
  materialForm: 'filament',
  description: 'Recycled plastic converted to 3D printing filament'
}]->(scrap);

// 3D Printer prints Chair
MATCH (printer:ThreeDPrinter {id: 'urn:ngsi-ld:ThreeDPrinter:001'})
MATCH (chair:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Chair:001'})
CREATE (printer)-[:PRINTS {
  printTime: 48,
  printTimeUnit: 'HOURS',
  layerCount: 12500,
  energyConsumption: 2.5,
  energyUnit: 'KWH',
  materialUsed: 2.5,
  materialUnit: 'KGM',
  co2Emissions: 0.00125,
  co2EmissionsUnit: 'tCO2',
  co2EmissionsDescription: 'CO2 from energy use (0.5 kg CO2/kWh)',
  co2Saved: 0.00325,
  co2SavedUnit: 'tCO2',
  co2SavedDescription: 'CO2 saved by using recycled vs virgin plastic'
}]->(chair);

// Chair has Scrap Material (closed loop!)
MATCH (chair:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Chair:001'})
MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP50:001'})
CREATE (chair)-[:HAS_MATERIAL {quantity: 2.5, unit: 'KGM', recycled: true}]->(scrap);

// Chair stored in Warehouse
MATCH (chair:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Chair:001'})
MATCH (wh:Warehouse {id: 'urn:ngsi-ld:Warehouse:001'})
CREATE (chair)-[:STORED_IN]->(wh);

// Chair produced by Circuprint
MATCH (chair:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Chair:001'})
MATCH (circuprint:Company {id: 'urn:ngsi-ld:Company:circuprint'})
CREATE (chair)-[:PRODUCED_BY]->(circuprint);

// ========================================
// VERIFICATION QUERIES
// ========================================

// Count all nodes
// MATCH (n) RETURN labels(n) as NodeType, count(n) as Count ORDER BY Count DESC;

// Show all relationships
// MATCH ()-[r]->() RETURN type(r) as RelationType, count(r) as Count ORDER BY Count DESC;

// Show complete manufacturing flow
// MATCH path = (supplier:Company)-[:SUPPLIED_BY*0..1]-(material:Material)<-[:PROCESSES_MATERIAL]-(machine:InjectionMoldingMachine)-[:MANUFACTURES]->(component:ManufacturingComponent)
// RETURN path;

// Show all nodes and relationships
// MATCH (n) RETURN n LIMIT 25;

// ========================================
// CO2 ENVIRONMENTAL IMPACT QUERIES
// ========================================

// Calculate total CO2 for Siphon manufacturing
// MATCH (m:Material {name: 'PP'})-[supply:SUPPLIED_BY]->(supplier:Company)
// MATCH (machine:InjectionMoldingMachine)-[manuf:MANUFACTURES]->(siphon:ManufacturingComponent {name: 'siphon'})
// RETURN 
//   m.totalCO2 as MaterialCO2_tCO2,
//   supply.co2Transport as TransportCO2_tCO2,
//   manuf.co2Emissions as ManufacturingCO2_tCO2,
//   (m.totalCO2 + supply.co2Transport + manuf.co2Emissions) as TotalSiphonCO2_tCO2;

// Calculate CO2 savings from circular economy (Chair from recycled material)
// MATCH (scrap:Material {materialType: 'Scrap'})-[print:PRINTS]->(chair:ManufacturingComponent {name: 'Chair'})
// RETURN 
//   scrap.co2Saved as CO2SavedByRecycling_tCO2,
//   print.co2Saved as CO2SavedByUsingRecycled_tCO2,
//   (scrap.co2Saved + print.co2Saved) as TotalCO2Saved_tCO2;

// Compare virgin vs recycled material CO2
// MATCH (virgin:Material {name: 'PP'})
// MATCH (scrap:Material {materialType: 'Scrap'})
// RETURN 
//   virgin.carbonFootprint as VirginPlastic_kgCO2perKg,
//   scrap.carbonFootprint as RecycledPlastic_kgCO2perKg,
//   (virgin.carbonFootprint - scrap.carbonFootprint) as CO2Reduction_kgCO2perKg,
//   ((virgin.carbonFootprint - scrap.carbonFootprint) / virgin.carbonFootprint * 100) as PercentReduction;
