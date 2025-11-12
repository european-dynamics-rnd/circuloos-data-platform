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
    id: 'urn:ngsi-ld:Material:PP',
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
    id: 'urn:ngsi-ld:Material:ScrapPP',
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
    id: 'urn:ngsi-ld:Company:rawplasticsa',
    name: 'RawPlasticsa Supplies',
    type: 'Company',
    description: 'Spanish supplier of raw and recycled plastic materials',
    category: ['Supplier', 'Raw Plastics' , 'Recycled Plastics' ]
  });


  CREATE (comp5:Company {
    id: 'urn:ngsi-ld:Company:replastauto',
    name: 'RePlastauto',
    type: 'Company',
    description: 'Plastic injection molding and recycled plastic company',
    category: ['Supplier','Manufacturing', 'Recycled Plastics']
  });

  CREATE (comp6:Company {
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
  id: 'urn:ngsi-ld:Warehouse',
  name: 'Warehouse 001',
  type: 'Warehouse'
});



  // ========================================
  // 5. CREATE INJECTION MOLDING MACHINE
  // ========================================

  CREATE (machine1:InjectionMoldingMachine {
    id: 'urn:ngsi-ld:InjectionMoldingMachine',
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
    id: 'urn:ngsi-ld:ManufacturingComponent:Siphon',
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
    id: 'urn:ngsi-ld:ThreeDPrinter',
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
    id: 'urn:ngsi-ld:ManufacturingComponent:Chair',
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

  // Material supplied by Company
  MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP'})
  MATCH (s:Company {id: 'urn:ngsi-ld:Company:rawplasticsa'})
  CREATE (m)-[:SUPPLIED_BY {
    priority: 1,
    transportDistance: 350,
    transportDistanceUnit: 'KM',
    co2Transport: 0.000042,
    co2TransportUnit: 'tCO2',
    co2TransportDescription: 'CO2 from truck transport (0.12 kg CO2/km)'
  }]->(s);

  MATCH (m:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
  MATCH (s:Company {id: 'urn:ngsi-ld:Company:rawplasticsa'})
  CREATE (m)-[:SUPPLIED_BY {
    priority: 1,
    transportDistance: 350,
    transportDistanceUnit: 'KM',
    co2Transport: 0.000042,
    co2TransportUnit: 'tCO2',
    co2TransportDescription: 'CO2 from truck transport (0.12 kg CO2/km)'
  }]->(s);

  MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP'})
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
  MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine'})
  MATCH (comp:Company {id: 'urn:ngsi-ld:Company:thermolympic'})
  CREATE (machine)-[:OWNED_BY]->(comp);



  // Machine MAKES Component
  MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine'})
  MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})
  CREATE (machine)-[:MAKES {
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
  MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})
  MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP'})
  CREATE (c)-[:HAS_MATERIAL {quantity: 0.10, unit: 'KGM'}]->(m);

  // Siphon can also use Scrap Material (circular economy - closed loop)
  MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})
  MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
  CREATE (c)-[:HAS_MATERIAL {
    quantity: 0.05, 
    unit: 'KGM', 
    recycled: true,
    description: 'Portion of siphon made from recycled scrap material'
  }]->(scrap);


  // Component produced by Company
  MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})
  MATCH (comp:Company {id: 'urn:ngsi-ld:Company:thermolympic'})
  CREATE (c)-[:PRODUCED_BY]->(comp);


// Material stored in Warehouse
MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP'})
MATCH (w:Warehouse {id: 'urn:ngsi-ld:Warehouse'})
CREATE (m)-[:STORED_IN]->(w);

// Component stored in Warehouse
MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})
MATCH (w:Warehouse {id: 'urn:ngsi-ld:Warehouse'})
CREATE (c)-[:STORED_IN]->(w);

  // Machine owned by Company
MATCH (wh:Warehouse {id: 'urn:ngsi-ld:Warehouse'})
  MATCH (comp:Company {id: 'urn:ngsi-ld:Company:thermolympic'})
  CREATE (wh)-[:OWNED_BY]->(comp);

  // ========================================
  // CIRCULAR ECONOMY - Scrap Material Loop
  // ========================================

  // Machine produces Scrap Material
  MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine'})
  MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
  CREATE (machine)-[:PRODUCES_SCRAP {
    percentage: 5,
    amount: 0.005,
    unit: 'KGM',
    description: 'Scrap from molding process'
  }]->(scrap);

  // Scrap Material returned to Supplier for recycling
  MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
  MATCH (supplier:Company {id: 'urn:ngsi-ld:Company:rawplasticsa'})
  CREATE (scrap)-[:RETURNED_TO {
    forRecycling: true,
    creditPerKg: 0.50,
    description: 'Circular economy - scrap returned for recycling'
  }]->(supplier);

  // Scrap Material also sent to replastauto for recycling
  MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
  MATCH (replastauto:Company {id: 'urn:ngsi-ld:Company:replastauto'})
  CREATE (scrap)-[:RETURNED_TO {
    forRecycling: true,
    creditPerKg: 0.60,
    description: 'Specialized recycling for 3D printing filament'
  }]->(replastauto);


  // ========================================
  // 3D PRINTING - Chair Production
  // ========================================

  // 3D Printer owned by Circuprint
  MATCH (printer:ThreeDPrinter {id: 'urn:ngsi-ld:ThreeDPrinter'})
  MATCH (circuprint:Company {id: 'urn:ngsi-ld:Company:circuprint'})
  CREATE (printer)-[:OWNED_BY]->(circuprint);


  // 3D Printer processes Scrap Material (from replastauto)
  MATCH (printer:ThreeDPrinter {id: 'urn:ngsi-ld:ThreeDPrinter'})
  MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
  CREATE (printer)-[:PROCESSES_MATERIAL {
    materialForm: 'filament',
    description: 'Recycled plastic converted to 3D printing filament'
  }]->(scrap);

  // 3D Printer prints Chair
  MATCH (printer:ThreeDPrinter {id: 'urn:ngsi-ld:ThreeDPrinter'})
  MATCH (chair:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Chair'})
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
  MATCH (chair:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Chair'})
  MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
  CREATE (chair)-[:HAS_MATERIAL {quantity: 2.5, unit: 'KGM', recycled: true}]->(scrap);

  MATCH (chair:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Chair'})
  MATCH (vergin:Material {id: 'urn:ngsi-ld:Material:PP'})
  CREATE (chair)-[:HAS_MATERIAL {quantity: 2.5, unit: 'KGM', recycled: true}]->(vergin);



  // Chair produced by Circuprint
  MATCH (chair:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Chair'})
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
  // MATCH path = (supplier:Company)-[:SUPPLIED_BY*0..1]-(material:Material)<-[:PROCESSES_MATERIAL]-(machine:InjectionMoldingMachine)-[:MAKES]->(component:ManufacturingComponent)
  // RETURN path;

  // Show all nodes and relationships
  // MATCH (n) RETURN n LIMIT 25;

  // ========================================
  // CO2 ENVIRONMENTAL IMPACT QUERIES
  // ========================================

  // Calculate total CO2 for Siphon manufacturing (100% virgin material - original)
  // MATCH (m:Material {name: 'PP'})-[supply:SUPPLIED_BY]->(supplier:Company)
  // MATCH (machine:InjectionMoldingMachine)-[manuf:MAKES]->(siphon:ManufacturingComponent {name: 'siphon'})
  // RETURN 
  //   m.totalCO2 as MaterialCO2_tCO2,
  //   supply.co2Transport as TransportCO2_tCO2,
  //   manuf.co2Emissions as ManufacturingCO2_tCO2,
  //   (m.totalCO2 + supply.co2Transport + manuf.co2Emissions) as TotalSiphonCO2_tCO2;

  // ========================================
  // CONFIGURABLE QUERY - Adjust Virgin vs Recycled Material Percentages
  // Change virginPercent value below (0.0 to 1.0, where 0.5 = 50%)
  // ========================================
  // MATCH (virgin:Material {id: 'urn:ngsi-ld:Material:PP'})
  // MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
  // MATCH (virgin)-[supply:SUPPLIED_BY]->(supplier:Company)
  // MATCH (scrap)-[supplyscrap:SUPPLIED_BY]->(supplier:Company)
  // MATCH (machine:InjectionMoldingMachine)-[manuf:MAKES]->(siphon:ManufacturingComponent)
  // WHERE supply.priority = 1 AND siphon.name = 'siphon'
  // WITH virgin, scrap, supply, supplyscrap, machine, manuf, siphon,
  //   0.30 as virginPercent  // <-- CHANGE THIS VALUE (0.0 to 1.0)
  // WITH virgin, scrap, supply, supplyscrap, machine, manuf, siphon, virginPercent,
  //   (1.0 - virginPercent) as recycledPercent,
  //   0.10 as totalWeight_kg
  // WITH virgin, scrap, supply, supplyscrap, machine, manuf, siphon, virginPercent, recycledPercent, totalWeight_kg,
  //   (totalWeight_kg * virginPercent) as virginWeight_kg,
  //   (totalWeight_kg * recycledPercent) as recycledWeight_kg
  // RETURN 
  //   '=== MATERIAL COMPOSITION ===' as Section1,
  //   (virginPercent * 100) as VirginPercent,
  //   (recycledPercent * 100) as RecycledPercent,
  //   totalWeight_kg as TotalSiphonWeight_kg,
  //   virginWeight_kg as VirginMaterial_kg,
  //   recycledWeight_kg as RecycledMaterial_kg,
  //   '=== VIRGIN MATERIAL CO2 ===' as Section2,
  //   virgin.carbonFootprint as VirginCarbonFootprint_kgCO2perKg,
  //   (virgin.carbonFootprint * virginWeight_kg / 1000) as VirginMaterialCO2_tCO2,
  //   (supply.co2Transport * virginPercent) as VirginTransportCO2_tCO2,
  //   ((virgin.carbonFootprint * virginWeight_kg / 1000) + (supply.co2Transport * virginPercent)) as VirginTotalCO2_tCO2,
  //   '=== RECYCLED MATERIAL CO2 ===' as Section3,
  //   scrap.carbonFootprint as RecycledCarbonFootprint_kgCO2perKg,
  //   (scrap.carbonFootprint * recycledWeight_kg / 1000) as RecycledMaterialCO2_tCO2,
  //   '=== MANUFACTURING CO2 ===' as Section4,
  //   manuf.co2Emissions as ManufacturingCO2_tCO2,
  //   '=== TRANSPORTATION CO2 ===' as Section4b,
  //   (supply.co2Transport * virginPercent) as virginTransportationCO2_tCO2,
  //   (supplyscrap.co2Transport * recycledPercent) as scrapTransportationCO2_tCO2,
  //   '=== TOTAL CO2 ===' as Section5,
  //   ((virgin.carbonFootprint * virginWeight_kg / 1000) + 
  //    (supply.co2Transport * virginPercent) + 
  //    (scrap.carbonFootprint * recycledWeight_kg / 1000) + 
  //    (supplyscrap.co2Transport * recycledPercent) + 
  //    manuf.co2Emissions) as TotalCO2_tCO2,
  //   '=== COMPARISON ===' as Section6,
  //   ((virgin.carbonFootprint * totalWeight_kg / 1000) + supply.co2Transport + manuf.co2Emissions) as CO2_100PercentVirgin_tCO2,
  //   (((virgin.carbonFootprint * totalWeight_kg / 1000) + supply.co2Transport + manuf.co2Emissions) -
  //    ((virgin.carbonFootprint * virginWeight_kg / 1000) + (supply.co2Transport * virginPercent) + (scrap.carbonFootprint * recycledWeight_kg / 1000) + (supplyscrap.co2Transport * recycledPercent) + manuf.co2Emissions)) as CO2_Saved_tCO2,
  //   ((((virgin.carbonFootprint * totalWeight_kg / 1000) + supply.co2Transport + manuf.co2Emissions) -
  //     ((virgin.carbonFootprint * virginWeight_kg / 1000) + (supply.co2Transport * virginPercent) + (scrap.carbonFootprint * recycledWeight_kg / 1000)+ (supplyscrap.co2Transport * recycledPercent) + manuf.co2Emissions)) /
  //    ((virgin.carbonFootprint * totalWeight_kg / 1000) + supply.co2Transport + manuf.co2Emissions) * 100) as PercentReduction;

  // ========================================
  // CIRCULAR ECONOMY ANALYSIS - Supply Routes with Circular Content
  // This query analyzes which supply routes provide materials with circular/recycled content
  // ========================================
  // MATCH (material:Material)-[supply:SUPPLIED_BY]->(supplier:Company)
  // OPTIONAL MATCH (component:ManufacturingComponent)-[has:HAS_MATERIAL]->(material)
  // WITH material, supplier, supply, 
  //   CASE 
  //     WHEN material.materialType = 'Scrap' THEN 1.0
  //     ELSE 0.0
  //   END as isRecycled,
  //   component
  // RETURN 
  //   '=== SUPPLY ROUTE ANALYSIS ===' as Section1,
  //   supplier.name as SupplierName,
  //   supplier.id as SupplierID,
  //   material.name as MaterialName,
  //   material.id as MaterialID,
  //   material.materialType as MaterialType,
  //   (isRecycled * 100) as CircularContent_Percent,
  //   CASE 
  //     WHEN isRecycled = 1.0 THEN 'Recycled/Circular'
  //     ELSE 'Virgin/Linear'
  //   END as SupplyType,
  //   supply.transportDistance as TransportDistance_km,
  //   supply.co2Transport as TransportCO2_tCO2,
  //   material.carbonFootprint as MaterialCarbonFootprint_kgCO2perKg,
  //   count(DISTINCT component) as ComponentsUsing
  // ORDER BY CircularContent_Percent DESC, TransportDistance_km ASC;

  // ========================================
  // SUPPLIER CIRCULAR ECONOMY RANKING
  // Ranks suppliers by their circular material offerings
  // ========================================
  // MATCH (material:Material)-[supply:SUPPLIED_BY]->(supplier:Company)
  // WITH supplier,
  //   count(material) as TotalMaterials,
  //   sum(CASE WHEN material.materialType = 'Scrap' THEN 1 ELSE 0 END) as RecycledMaterials,
  //   avg(supply.transportDistance) as AvgTransportDistance,
  //   avg(supply.co2Transport) as AvgTransportCO2
  // RETURN 
  //   '=== SUPPLIER CIRCULAR RANKING ===' as Title,
  //   supplier.name as SupplierName,
  //   TotalMaterials as TotalMaterialsSupplied,
  //   RecycledMaterials as RecycledMaterialsSupplied,
  //   ((RecycledMaterials * 1.0 / TotalMaterials) * 100) as CircularContent_Percent,
  //   AvgTransportDistance as AvgTransportDistance_km,
  //   AvgTransportCO2 as AvgTransportCO2_tCO2,
  //   CASE 
  //     WHEN (RecycledMaterials * 1.0 / TotalMaterials) >= 0.5 THEN 'High Circular Economy'
  //     WHEN (RecycledMaterials * 1.0 / TotalMaterials) > 0 THEN 'Mixed Supply'
  //     ELSE 'Linear Economy Only'
  //   END as SupplierCategory
  // ORDER BY CircularContent_Percent DESC, AvgTransportDistance_km ASC;

  // ========================================
  // COMPLETE CIRCULAR FLOW ANALYSIS
  // Shows the full circular economy flow from supplier through manufacturing to products
  // ========================================
  // MATCH (supplier:Company)<-[:SUPPLIED_BY]-(material:Material)
  // OPTIONAL MATCH (material)<-[:PROCESSES_MATERIAL]-(machine:InjectionMoldingMachine)
  // OPTIONAL MATCH (machine)-[:MAKES]->(component:ManufacturingComponent)
  // OPTIONAL MATCH (component)-[has:HAS_MATERIAL]->(material)
  // WITH supplier, material, machine, component, has,
  //   CASE 
  //     WHEN material.materialType = 'Scrap' THEN 'Circular'
  //     ELSE 'Linear'
  //   END as EconomyType
  // RETURN 
  //   '=== CIRCULAR FLOW ANALYSIS ===' as Title,
  //   supplier.name as Supplier,
  //   material.name as Material,
  //   EconomyType as SupplyChainType,
  //   machine.name as ProcessedBy,
  //   component.name as ProducedComponent,
  //   has.quantity as MaterialQuantityInComponent_kg,
  //   has.recycled as IsRecycledInComponent,
  //   material.carbonFootprint as MaterialCO2_kgCO2perKg,
  //   CASE 
  //     WHEN material.materialType = 'Scrap' THEN material.co2Saved
  //     ELSE 0
  //   END as CO2Saved_tCO2
  // ORDER BY EconomyType DESC, supplier.name;