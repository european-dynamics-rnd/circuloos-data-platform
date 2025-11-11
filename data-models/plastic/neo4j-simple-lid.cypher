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
  name: 'PP + 50% CO3Ca',
  type: 'Material',
  specification: 'ISOFIL H50 C2V NATURALSIRMAX',
  stockLevel: 1.2,
  unitCode: 'KGM'
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
  id: 'urn:ngsi-ld:ManufacturingComponent:Siphon:001  ',
  name: 'siphon',
  type: 'ManufacturingComponent',
  weight: 0.10,
  weightUnit: 'KGM',
  stockLevel: 10,
  lastTimeUsed: '2025-10-20T10:00:00Z'
});

// ========================================
// 7. CREATE SCRAP MATERIAL (for circular economy)
// ========================================

CREATE (scrap1:Material {
  id: 'urn:ngsi-ld:Material:ScrapPP50CO3Ca:001',
  name: 'Scrap PP + 50% CO3Ca',
  type: 'Material',
  materialType: 'Scrap',
  specification: 'Recycled plastic from injection molding',
  stockLevel: 0.15,
  unitCode: 'KGM',
  recyclable: true
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
CREATE (m)-[:SUPPLIED_BY {priority: 1}]->(s);

MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP:001'})
MATCH (s:Company {id: 'urn:ngsi-ld:Company:iberoplast'})
CREATE (m)-[:SUPPLIED_BY {priority: 2}]->(s);

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
  totalProductionTime: 105
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
MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP50CO3Ca:001'})
CREATE (machine)-[:PRODUCES_SCRAP {
  percentage: 5,
  amount: 0.005,
  unit: 'KGM',
  description: 'Scrap from molding process'
}]->(scrap);

// Scrap Material returned to Supplier for recycling
MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP50CO3Ca:001'})
MATCH (supplier:Company {id: 'urn:ngsi-ld:Company:rawplasticsa'})
CREATE (scrap)-[:RETURNED_TO {
  forRecycling: true,
  creditPerKg: 0.50,
  description: 'Circular economy - scrap returned for recycling'
}]->(supplier);

// Scrap stored in Warehouse before return
MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP50CO3Ca:001'})
MATCH (wh:Warehouse {id: 'urn:ngsi-ld:Warehouse:001'})
CREATE (scrap)-[:STORED_IN]->(wh);

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
