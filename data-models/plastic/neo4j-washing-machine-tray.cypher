// ========================================
// CIRCULOOS Plastic Manufacturing - Neo4j Graph Database
// Washing Machine Tray Digital Twin with Injection Molding Machines
// ========================================

// Clear existing data (optional - comment out if you want to preserve existing data)
// MATCH (n) DETACH DELETE n;

// ========================================
// 1. CREATE MATERIALS
// ========================================

CREATE (mat1:Material {
  id: 'urn:ngsi-ld:Material:PP50CO3Ca:001',
  name: 'PP + 50% CO3Ca',
  type: 'Material',
  composition_PP: 50,
  composition_CO3Ca: 50,
  specification: 'ISOFIL H50 C2V NATURALSIRMAX',
  stockLevel: 1.2,
  unitCode: 'KGM'
});

CREATE (mat2:Material {
  id: 'urn:ngsi-ld:Material:PP30Talco:001',
  name: 'PP + talco 30%',
  type: 'Material',
  composition_PP: 70,
  composition_talco: 30,
  specification: 'Hostacom HKC 182 L W92607 WHITE',
  stockLevel: 10.2,
  unitCode: 'KGM'
});

CREATE (mat3:Material {
  id: 'urn:ngsi-ld:Material:PP:001',
  name: 'PP',
  type: 'Material',
  composition_PP: 100,
  specification: 'ISOFIL HK 30 TFH2 BL2092',
  stockLevel: 100.2,
  unitCode: 'KGM'
});

CREATE (mat4:Material {
  id: 'urn:ngsi-ld:Material:aluminum:001',
  name: 'aluminum',
  type: 'Material',
  composition_Al: 100
});

// ========================================
// 2. CREATE COMPANIES
// ========================================

CREATE (comp1:Company {
  id: 'urn:ngsi-ld:Company:thermolympic',
  name: 'Thermolympic',
  type: 'Company',
  streetAddress: 'Pol. Ind. El Segre, Calle A, Parcela 223',
  city: 'Lleida',
  region: 'Catalonia',
  country: 'Spain',
  postalCode: '25191',
  longitude: 0.6265,
  latitude: 41.6176,
  description: 'A Spanish company specializing in plastic injection molding and industrial solutions.',
  category: ['Manufacturing', 'Plastics'],
  telephone: '+34-973-257-000',
  email: 'info@thermolympic.com',
  openingHours: 'Mo-Fr 08:00-17:00'
});

CREATE (comp2:Company {
  id: 'urn:ngsi-ld:Company:aluminext',
  name: 'AlumiNext S.A.',
  type: 'Company',
  streetAddress: 'Calle de la Industria, 45',
  city: 'Zaragoza',
  region: 'Aragon',
  country: 'Spain',
  postalCode: '50018',
  longitude: -0.8891,
  latitude: 41.6488,
  description: 'Leading Spanish manufacturer of precision aluminum parts for industry.',
  category: ['Manufacturing', 'Aluminum Parts'],
  telephone: '+34-976-123-456',
  email: 'contact@aluminext.es',
  openingHours: 'Mo-Fr 07:00-15:00'
});

CREATE (comp3:Company {
  id: 'urn:ngsi-ld:Company:rawplasticsa',
  name: 'RawPlastic S.A.',
  type: 'Company',
  streetAddress: 'Avenida de la Innovación, 12',
  city: 'Valencia',
  region: 'Valencian Community',
  country: 'Spain',
  postalCode: '46026',
  longitude: -0.3763,
  latitude: 39.4699,
  description: 'Supplier of raw plastic materials for manufacturing companies.',
  category: ['Supplier', 'Raw Plastics'],
  telephone: '+34-961-234-567',
  email: 'info@rawplasticsa.es',
  openingHours: 'Mo-Fr 08:00-16:00'
});

CREATE (comp4:Company {
  id: 'urn:ngsi-ld:Company:iberoplast',
  name: 'IberoPlast Supplies',
  type: 'Company',
  streetAddress: 'Polígono Sur, Parcela 8',
  city: 'Seville',
  region: 'Andalusia',
  country: 'Spain',
  postalCode: '41013',
  longitude: -5.9845,
  latitude: 37.3891,
  description: 'Spanish supplier of raw plastic parts and materials for industry.',
  category: ['Supplier', 'Raw Plastics'],
  telephone: '+34-954-321-654',
  email: 'ventas@iberoplast.es',
  openingHours: 'Mo-Fr 09:00-17:00'
});

// ========================================
// 3. CREATE WAREHOUSES
// ========================================

CREATE (wh1:Warehouse {
  id: 'urn:ngsi-ld:Warehouse:001',
  name: 'Warehouse 001',
  type: 'Warehouse',
  description: 'Warehouse for plastic parts',
  streetAddress: 'Avenida Alemania s/n',
  city: 'Utebo',
  region: 'Zaragoza',
  country: 'Spain',
  postalCode: '50180',
  longitude: -1.0098,
  latitude: 41.6891
});

CREATE (wh2:Warehouse {
  id: 'urn:ngsi-ld:Warehouse:002',
  name: 'Warehouse 002',
  type: 'Warehouse',
  description: 'Warehouse for metal parts',
  streetAddress: 'Avenida Alemania s/n',
  city: 'Utebo',
  region: 'Zaragoza',
  country: 'Spain',
  postalCode: '50180',
  longitude: -1.1098,
  latitude: 41.3891
});

// ========================================
// 4. CREATE INJECTION MOLDING MACHINES
// ========================================

CREATE (machine1:InjectionMoldingMachine {
  id: 'urn:ngsi-ld:InjectionMoldingMachine:thermolympic:001',
  name: 'Injection Molding Machine #1',
  type: 'InjectionMoldingMachine',
  manufacturer: 'Engel',
  model: 'e-victory 200/80',
  clampingForce: 200,
  clampingForceUnit: 'TON',
  injectionVolume: 290,
  injectionVolumeUnit: 'CM3',
  maxInjectionPressure: 2100,
  maxInjectionPressureUnit: 'BAR',
  plasticizingCapacity: 110,
  plasticizingCapacityUnit: 'G/S',
  energyConsumptionPerCycle: 0.055,
  energyConsumptionUnit: 'KWH',
  cycleTime: 45,
  cycleTimeUnit: 'SECONDS',
  status: 'operational',
  operatingHours: 45230,
  lastMaintenance: '2025-09-15T10:00:00Z',
  nextMaintenance: '2025-12-15T10:00:00Z'
});

CREATE (machine2:InjectionMoldingMachine {
  id: 'urn:ngsi-ld:InjectionMoldingMachine:thermolympic:002',
  name: 'Injection Molding Machine #2',
  type: 'InjectionMoldingMachine',
  manufacturer: 'Krauss Maffei',
  model: 'GX 450-2000',
  clampingForce: 450,
  clampingForceUnit: 'TON',
  injectionVolume: 850,
  injectionVolumeUnit: 'CM3',
  maxInjectionPressure: 2200,
  maxInjectionPressureUnit: 'BAR',
  plasticizingCapacity: 180,
  plasticizingCapacityUnit: 'G/S',
  energyConsumptionPerCycle: 0.12,
  energyConsumptionUnit: 'KWH',
  cycleTime: 60,
  cycleTimeUnit: 'SECONDS',
  status: 'operational',
  operatingHours: 38750,
  lastMaintenance: '2025-08-20T10:00:00Z',
  nextMaintenance: '2025-11-20T10:00:00Z'
});

CREATE (machine3:InjectionMoldingMachine {
  id: 'urn:ngsi-ld:InjectionMoldingMachine:thermolympic:003',
  name: 'Injection Molding Machine #3',
  type: 'InjectionMoldingMachine',
  manufacturer: 'Arburg',
  model: 'Allrounder 370 S',
  clampingForce: 100,
  clampingForceUnit: 'TON',
  injectionVolume: 90,
  injectionVolumeUnit: 'CM3',
  maxInjectionPressure: 2000,
  maxInjectionPressureUnit: 'BAR',
  plasticizingCapacity: 45,
  plasticizingCapacityUnit: 'G/S',
  energyConsumptionPerCycle: 0.015,
  energyConsumptionUnit: 'KWH',
  cycleTime: 30,
  cycleTimeUnit: 'SECONDS',
  status: 'operational',
  operatingHours: 32100,
  lastMaintenance: '2025-10-01T10:00:00Z',
  nextMaintenance: '2026-01-01T10:00:00Z'
});

// ========================================
// 5. CREATE MANUFACTURING COMPONENTS
// ========================================

CREATE (comp_lid:ManufacturingComponent {
  id: 'urn:ngsi-ld:ManufacturingComponent:lid:001',
  name: 'Lid',
  type: 'ManufacturingComponent',
  energyConsumption: 0.11,
  energyUnit: 'KWH',
  weight: 0.10,
  weightUnit: 'KGM',
  stockLevel: 10,
  lastTimeUsed: '2025-10-20T10:00:00Z',
  moldingCycles: 2,
  moldingCycleTime: 45
});

CREATE (comp_distributor:ManufacturingComponent {
  id: 'urn:ngsi-ld:ManufacturingComponent:distributor:001',
  name: 'Distributor',
  type: 'ManufacturingComponent',
  energyConsumption: 0.11,
  energyUnit: 'KWH',
  weight: 0.25,
  weightUnit: 'KGM',
  stockLevel: 10,
  lastTimeUsed: '2025-10-20T10:00:00Z',
  moldingCycles: 2,
  moldingCycleTime: 45
});

CREATE (comp_fixedTub:ManufacturingComponent {
  id: 'urn:ngsi-ld:ManufacturingComponent:fixedTub:001',
  name: 'Fixed tub',
  type: 'ManufacturingComponent',
  energyConsumption: 0.24,
  energyUnit: 'KWH',
  weight: 0.22,
  weightUnit: 'KGM',
  stockLevel: 10,
  lastTimeUsed: '2025-10-20T10:00:00Z',
  moldingCycles: 4,
  moldingCycleTime: 60
});

CREATE (comp_slidingTub:ManufacturingComponent {
  id: 'urn:ngsi-ld:ManufacturingComponent:slidingTub:001',
  name: 'Sliding tub',
  type: 'ManufacturingComponent',
  energyConsumption: 0.24,
  energyUnit: 'KWH',
  weight: 0.20,
  weightUnit: 'KGM',
  stockLevel: 10,
  lastTimeUsed: '2025-10-20T10:00:00Z',
  moldingCycles: 4,
  moldingCycleTime: 60
});

CREATE (comp_siphon:ManufacturingComponent {
  id: 'urn:ngsi-ld:ManufacturingComponent:siphon:001',
  name: 'Siphon',
  type: 'ManufacturingComponent',
  energyConsumption: 0.03,
  energyUnit: 'KWH',
  weight: 0.03,
  weightUnit: 'KGM',
  stockLevel: 10,
  lastTimeUsed: '2025-10-20T10:00:00Z',
  moldingCycles: 2,
  moldingCycleTime: 30
});

CREATE (comp_metalClamp:ManufacturingComponent {
  id: 'urn:ngsi-ld:ManufacturingComponent:metalClamp:001',
  name: 'Metal clamp',
  type: 'ManufacturingComponent',
  energyConsumption: 0.00,
  energyUnit: 'KWH',
  weight: 0.00187,
  weightUnit: 'KGM',
  stockLevel: 10,
  lastTimeUsed: '2025-10-20T10:00:00Z'
});

CREATE (comp_pipeTub:ManufacturingComponent {
  id: 'urn:ngsi-ld:ManufacturingComponent:pipeTub:001',
  name: 'Pipe tub',
  type: 'ManufacturingComponent',
  energyConsumption: 0.00,
  energyUnit: 'KWH',
  weight: 0.00976,
  weightUnit: 'KGM',
  stockLevel: 10,
  lastTimeUsed: '2025-10-20T10:00:00Z'
});

// ========================================
// 6. CREATE FINAL PRODUCT
// ========================================

CREATE (product:ManufacturingMachine {
  id: 'urn:ngsi-ld:ManufacturingMachine:washingMachineTray:001',
  name: 'Washing Machine Tray Assembly',
  type: 'ManufacturingMachine',
  description: 'Complete washing machine tray with all components',
  dateCreated: '2025-10-22T12:00:00Z',
  totalEnergyConsumption: 0.73,
  energyUnit: 'KWH',
  totalWeight: 0.79163,
  weightUnit: 'KGM',
  totalComponents: 7
});

// ========================================
// 7. CREATE RELATIONSHIPS - Product to Components
// ========================================

MATCH (p:ManufacturingMachine {id: 'urn:ngsi-ld:ManufacturingMachine:washingMachineTray:001'})
MATCH (c:ManufacturingComponent)
WHERE c.id IN [
  'urn:ngsi-ld:ManufacturingComponent:lid:001',
  'urn:ngsi-ld:ManufacturingComponent:distributor:001',
  'urn:ngsi-ld:ManufacturingComponent:fixedTub:001',
  'urn:ngsi-ld:ManufacturingComponent:slidingTub:001',
  'urn:ngsi-ld:ManufacturingComponent:siphon:001',
  'urn:ngsi-ld:ManufacturingComponent:metalClamp:001',
  'urn:ngsi-ld:ManufacturingComponent:pipeTub:001'
]
CREATE (p)-[:HAS_COMPONENT]->(c);

// ========================================
// 8. CREATE RELATIONSHIPS - Components to Materials
// ========================================

MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:lid:001'})
MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP50CO3Ca:001'})
CREATE (c)-[:HAS_MATERIAL {quantity: 0.10, unit: 'KGM'}]->(m);

MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:distributor:001'})
MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP50CO3Ca:001'})
CREATE (c)-[:HAS_MATERIAL {quantity: 0.25, unit: 'KGM'}]->(m);

MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:fixedTub:001'})
MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP30Talco:001'})
CREATE (c)-[:HAS_MATERIAL {quantity: 0.22, unit: 'KGM'}]->(m);

MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:slidingTub:001'})
MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP30Talco:001'})
CREATE (c)-[:HAS_MATERIAL {quantity: 0.20, unit: 'KGM'}]->(m);

MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:siphon:001'})
MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP:001'})
CREATE (c)-[:HAS_MATERIAL {quantity: 0.03, unit: 'KGM'}]->(m);

MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:metalClamp:001'})
MATCH (m:Material {id: 'urn:ngsi-ld:Material:aluminum:001'})
CREATE (c)-[:HAS_MATERIAL {quantity: 0.00187, unit: 'KGM'}]->(m);

MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:pipeTub:001'})
MATCH (m:Material {id: 'urn:ngsi-ld:Material:aluminum:001'})
CREATE (c)-[:HAS_MATERIAL {quantity: 0.00976, unit: 'KGM'}]->(m);

// ========================================
// 9. CREATE RELATIONSHIPS - Components to Warehouses
// ========================================

MATCH (c:ManufacturingComponent)
WHERE c.id IN [
  'urn:ngsi-ld:ManufacturingComponent:lid:001',
  'urn:ngsi-ld:ManufacturingComponent:distributor:001',
  'urn:ngsi-ld:ManufacturingComponent:fixedTub:001',
  'urn:ngsi-ld:ManufacturingComponent:slidingTub:001',
  'urn:ngsi-ld:ManufacturingComponent:siphon:001'
]
MATCH (w:Warehouse {id: 'urn:ngsi-ld:Warehouse:001'})
CREATE (c)-[:STORED_IN]->(w);

MATCH (c:ManufacturingComponent)
WHERE c.id IN [
  'urn:ngsi-ld:ManufacturingComponent:metalClamp:001',
  'urn:ngsi-ld:ManufacturingComponent:pipeTub:001'
]
MATCH (w:Warehouse {id: 'urn:ngsi-ld:Warehouse:002'})
CREATE (c)-[:STORED_IN]->(w);

// ========================================
// 10. CREATE RELATIONSHIPS - Materials to Warehouses
// ========================================

MATCH (m:Material)
WHERE m.id IN [
  'urn:ngsi-ld:Material:PP50CO3Ca:001',
  'urn:ngsi-ld:Material:PP30Talco:001',
  'urn:ngsi-ld:Material:PP:001'
]
MATCH (w:Warehouse {id: 'urn:ngsi-ld:Warehouse:001'})
CREATE (m)-[:STORED_IN]->(w);

// ========================================
// 11. CREATE RELATIONSHIPS - Components to Producers
// ========================================

MATCH (c:ManufacturingComponent)
WHERE c.id IN [
  'urn:ngsi-ld:ManufacturingComponent:lid:001',
  'urn:ngsi-ld:ManufacturingComponent:distributor:001',
  'urn:ngsi-ld:ManufacturingComponent:fixedTub:001',
  'urn:ngsi-ld:ManufacturingComponent:slidingTub:001',
  'urn:ngsi-ld:ManufacturingComponent:siphon:001'
]
MATCH (comp:Company {id: 'urn:ngsi-ld:Company:thermolympic'})
CREATE (c)-[:PRODUCED_BY]->(comp);

MATCH (c:ManufacturingComponent)
WHERE c.id IN [
  'urn:ngsi-ld:ManufacturingComponent:metalClamp:001',
  'urn:ngsi-ld:ManufacturingComponent:pipeTub:001'
]
MATCH (comp:Company {id: 'urn:ngsi-ld:Company:aluminext'})
CREATE (c)-[:PRODUCED_BY]->(comp);

// ========================================
// 12. CREATE RELATIONSHIPS - Materials to Suppliers
// ========================================

MATCH (m:Material)
WHERE m.id IN [
  'urn:ngsi-ld:Material:PP50CO3Ca:001',
  'urn:ngsi-ld:Material:PP30Talco:001',
  'urn:ngsi-ld:Material:PP:001'
]
MATCH (s1:Company {id: 'urn:ngsi-ld:Company:rawplasticsa'})
MATCH (s2:Company {id: 'urn:ngsi-ld:Company:iberoplast'})
CREATE (m)-[:SUPPLIED_BY {priority: 1}]->(s1)
CREATE (m)-[:SUPPLIED_BY {priority: 2}]->(s2);

// ========================================
// 13. CREATE RELATIONSHIPS - Injection Machines to Company
// ========================================

MATCH (machine:InjectionMoldingMachine)
MATCH (comp:Company {id: 'urn:ngsi-ld:Company:thermolympic'})
CREATE (machine)-[:OWNED_BY]->(comp);

MATCH (machine:InjectionMoldingMachine)
MATCH (wh:Warehouse {id: 'urn:ngsi-ld:Warehouse:001'})
CREATE (machine)-[:LOCATED_IN]->(wh);

// ========================================
// 14. CREATE RELATIONSHIPS - Injection Machines to Components
// ========================================

// Machine 1 produces Lid and Distributor
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine:thermolympic:001'})
MATCH (c:ManufacturingComponent)
WHERE c.id IN [
  'urn:ngsi-ld:ManufacturingComponent:lid:001',
  'urn:ngsi-ld:ManufacturingComponent:distributor:001'
]
CREATE (machine)-[:MANUFACTURES {
  cyclesPerComponent: 2,
  avgCycleTime: 45,
  setupTime: 15,
  totalProductionTime: 105
}]->(c);

// Machine 2 produces Fixed Tub and Sliding Tub
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine:thermolympic:002'})
MATCH (c:ManufacturingComponent)
WHERE c.id IN [
  'urn:ngsi-ld:ManufacturingComponent:fixedTub:001',
  'urn:ngsi-ld:ManufacturingComponent:slidingTub:001'
]
CREATE (machine)-[:MANUFACTURES {
  cyclesPerComponent: 4,
  avgCycleTime: 60,
  setupTime: 20,
  totalProductionTime: 260
}]->(c);

// Machine 3 produces Siphon
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine:thermolympic:003'})
MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:siphon:001'})
CREATE (machine)-[:MANUFACTURES {
  cyclesPerComponent: 2,
  avgCycleTime: 30,
  setupTime: 10,
  totalProductionTime: 70
}]->(c);

// ========================================
// 15. CREATE RELATIONSHIPS - Injection Machines to Materials
// ========================================

// Machine 1 uses PP50CO3Ca
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine:thermolympic:001'})
MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP50CO3Ca:001'})
CREATE (machine)-[:PROCESSES_MATERIAL]->(m);

// Machine 2 uses PP30Talco
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine:thermolympic:002'})
MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP30Talco:001'})
CREATE (machine)-[:PROCESSES_MATERIAL]->(m);

// Machine 3 uses PP
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine:thermolympic:003'})
MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP:001'})
CREATE (machine)-[:PROCESSES_MATERIAL]->(m);

// ========================================
// 16. CREATE INDEXES FOR PERFORMANCE
// ========================================

// CREATE INDEX material_id IF NOT EXISTS FOR (m:Material) ON (m.id);
// CREATE INDEX component_id IF NOT EXISTS FOR (c:ManufacturingComponent) ON (c.id);
// CREATE INDEX product_id IF NOT EXISTS FOR (p:ManufacturingMachine) ON (p.id);
// CREATE INDEX company_id IF NOT EXISTS FOR (c:Company) ON (c.id);
// CREATE INDEX warehouse_id IF NOT EXISTS FOR (w:Warehouse) ON (w.id);
// CREATE INDEX machine_id IF NOT EXISTS FOR (m:InjectionMoldingMachine) ON (m.id);

// ========================================
// VERIFICATION QUERIES

// NOTE: Run these queries AFTER loading all data
// Do not include these in automated data loading

// ========================================

// Count all nodes
// MATCH (n) RETURN labels(n) as NodeType, count(n) as Count;

// Show complete product structure
// MATCH path = (product:ManufacturingMachine)-[:HAS_COMPONENT]->(component:ManufacturingComponent)-[:HAS_MATERIAL]->(material:Material)
// RETURN product.name, component.name, material.name, component.weight;

// Show injection molding machine assignments
// MATCH (machine:InjectionMoldingMachine)-[r:MANUFACTURES]->(component:ManufacturingComponent)
// RETURN machine.name, component.name, r.cyclesPerComponent, r.avgCycleTime, r.totalProductionTime;

// Calculate total production time for all components
// MATCH (machine:InjectionMoldingMachine)-[r:MANUFACTURES]->(component:ManufacturingComponent)
// RETURN SUM(r.totalProductionTime) as TotalProductionTimeSeconds, 
//        SUM(r.totalProductionTime)/60 as TotalProductionTimeMinutes;

// Show material flow from suppliers through machines to components
// MATCH path = (supplier:Company)-[:SUPPLIED_BY*0..1]-(material:Material)<-[:PROCESSES_MATERIAL]-(machine:InjectionMoldingMachine)-[:MANUFACTURES]->(component:ManufacturingComponent)
// WHERE supplier.id IN ['urn:ngsi-ld:Company:rawplasticsa', 'urn:ngsi-ld:Company:iberoplast']
// RETURN supplier.name, material.name, machine.name, component.name;