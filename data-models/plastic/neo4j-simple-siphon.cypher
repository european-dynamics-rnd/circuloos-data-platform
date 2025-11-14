  // ========================================
  // CIRCULOOS Plastic Manufacturing - Neo4j Graph Database (SIMPLIFIED)
  // Single Component Example: siphon
  // ========================================

  // Clear existing data (optional)
  MATCH (n) DETACH DELETE n;

  // ========================================
  // 1. CREATE MATERIAL
  // ========================================

  CREATE (mat1:Material {
    id: 'urn:ngsi-ld:Material:PP',
    name: 'PP',
    type: 'Material',
    stockLevel_kg: 230.2,
    carbonFootprint: 1.8,
    carbonFootprintUnit: 'KG_CO2_PER_KG',
    totalCO2_tCO2: 0.0022
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
    stockLevel_kg: 130.15,
    recyclable: true,
    carbonFootprint: 0.4,
    carbonFootprintUnit: 'KG_CO2_PER_KG',
    totalCO2: 0.00006,
    co2Saved: 0.00021,
    co2SavedDescription: 'CO2 saved by recycling vs virgin plastic'
  });

  // ========================================
  // CREATE RECYCLED MATERIAL (processed from scrap)
  // ========================================

  CREATE (recycle1:Material {
    id: 'urn:ngsi-ld:Material:RecyclePP',
    name: 'Recycle PP',
    type: 'Material',
    materialType: 'Recycled',
    stockLevel_kg: 85.5,
    recyclable: true,
    carbonFootprint: 0.5,
    carbonFootprintUnit: 'KG_CO2_PER_KG',
    totalCO2: 0.00004,
    co2Saved: 0.00015,
    co2SavedDescription: 'CO2 saved by using recycled material vs virgin plastic'
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
    cycleTime_s: 45,
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
    rawMaterialPerPart_kg: 0.10,
    stockLevel: 10
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
    rawMaterialPerPart_kg : 2.5,
    stockLevel: 5,
    description: '3D printed chair from recycled materials'
  });



  // ========================================
  // 8. CREATE RELATIONSHIPS
  // ========================================

  // Material supplied by Company
  WITH 0.12 AS co2PerKm_kgCO2, 350 AS transportDistance_km
  MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP'})
  MATCH (s:Company {id: 'urn:ngsi-ld:Company:rawplasticsa'})
  WITH m, s, co2PerKm_kgCO2, transportDistance_km
  CREATE (m)-[:SUPPLIED_BY {
    priority: 1,
    transportDistance_km: transportDistance_km,
    co2Transport_tCO2: (transportDistance_km * co2PerKm_kgCO2 / 1000),
    co2TransportDescription: 'CO2 from truck transport (' + toString(co2PerKm_kgCO2) + ' kg CO2/km)'
  }]->(s);

  // Lollo recycles ScrapPP to create RecyclePP
  WITH 0.12 AS co2PerKm_kgCO2, 420 AS transportDistance_km, 12.5 AS energyConsumption_kWh, 0.5 AS co2PerKWh_kgCO2
  MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
  MATCH (lollo:Company {id: 'urn:ngsi-ld:Company:Lollo'})
  WITH scrap, lollo, co2PerKm_kgCO2, transportDistance_km, energyConsumption_kWh, co2PerKWh_kgCO2
  CREATE (scrap)-[:RECYCLED_BY {
    energyConsumption_kWh: energyConsumption_kWh,
    co2Emissions_tCO2: (energyConsumption_kWh * co2PerKWh_kgCO2 / 1000),
    co2EmissionsDescription: 'CO2 from recycling process energy (' + toString(co2PerKWh_kgCO2) + ' kg CO2/kWh)',
    transportDistance_km: transportDistance_km,
    co2Transport_tCO2: (transportDistance_km * co2PerKm_kgCO2 / 1000),
    co2TransportDescription: 'CO2 from truck transport (' + toString(co2PerKm_kgCO2) + ' kg CO2/km)'
  }]->(lollo);
  
  WITH 0.12 AS co2PerKm_kgCO2, 350 AS transportDistance_km, 12.5 AS energyConsumption_kWh, 0.5 AS co2PerKWh_kgCO2
  MATCH (m:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
  MATCH (s:Company {id: 'urn:ngsi-ld:Company:rawplasticsa'})
  WITH m, s, co2PerKm_kgCO2, transportDistance_km, energyConsumption_kWh, co2PerKWh_kgCO2
  CREATE (m)-[:RECYCLED_BY {
    priority: 1,
    energyConsumption_kWh: energyConsumption_kWh,
    co2Emissions_tCO2: (energyConsumption_kWh * co2PerKWh_kgCO2 / 1000),
    co2EmissionsDescription: 'CO2 from recycling process energy (' + toString(co2PerKWh_kgCO2) + ' kg CO2/kWh)',
    transportDistance_km: transportDistance_km,
    co2Transport_tCO2: (transportDistance_km * co2PerKm_kgCO2 / 1000),
    co2TransportDescription: 'CO2 from truck transport (' + toString(co2PerKm_kgCO2) + ' kg CO2/km)'
  }]->(s);

  // RecyclePP supplied by Lollo
  WITH 0.12 AS co2PerKm_kgCO2, 420 AS transportDistance_km
  MATCH (recycle:Material {id: 'urn:ngsi-ld:Material:RecyclePP'})
  MATCH (lollo:Company {id: 'urn:ngsi-ld:Company:Lollo'})
  WITH recycle, lollo, co2PerKm_kgCO2, transportDistance_km
  CREATE (recycle)-[:SUPPLIED_BY {
    priority: 1,
    transportDistance_km: transportDistance_km,
    co2Transport_tCO2: (transportDistance_km * co2PerKm_kgCO2 / 1000),
    co2TransportDescription: 'CO2 from truck transport (' + toString(co2PerKm_kgCO2) + ' kg CO2/km)'
  }]->(lollo);


  WITH 0.12 AS co2PerKm_kgCO2, 650 AS transportDistance_km
  MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP'})
  MATCH (s:Company {id: 'urn:ngsi-ld:Company:iberoplast'})
  WITH m, s, co2PerKm_kgCO2, transportDistance_km
  CREATE (m)-[:SUPPLIED_BY {
    priority: 2,
    transportDistance_km: transportDistance_km,
    co2Transport_tCO2: (transportDistance_km * co2PerKm_kgCO2 / 1000),
    co2TransportDescription: 'CO2 from truck transport (' + toString(co2PerKm_kgCO2) + ' kg CO2/km)'
  }]->(s);

  // Machine owned by Company
  MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine'})
  MATCH (comp:Company {id: 'urn:ngsi-ld:Company:thermolympic'})
  CREATE (machine)-[:OWNED_BY]->(comp);
  MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine'})
  MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})
  CREATE (machine)-[:MAKES {
    // moldingCycles: 2,
    // moldingCycleTime: 45,
    // setupTime: 15,
    totalProductionTime: 105,
    energyConsumption_kWh: 0.11,
    co2Emissions_tCO2: 0.000055,
    co2EmissionsDescription: 'CO2 from energy use (0.5 kg CO2/kWh)'
  }]->(c);

  // Component has Material
  MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})
  MATCH (m:Material {id: 'urn:ngsi-ld:Material:PP'})
  //  {quantity: 0.10, unit: 'KGM'}
  CREATE (c)-[:HAS_MATERIAL]->(m);

  // Siphon can also use RecyclePP (processed recycled material from Lollo)
  MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})
  MATCH (recycle:Material {id: 'urn:ngsi-ld:Material:RecyclePP'})
  CREATE (c)-[:HAS_MATERIAL ]->(recycle);


  // Component produced by Company
  MATCH (c:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})
  MATCH (comp:Company {id: 'urn:ngsi-ld:Company:thermolympic'})
  CREATE (c)-[:PRODUCED_BY]->(comp);

  // ========================================
  // CIRCULAR ECONOMY - Scrap Material Loop
  // ========================================

  // Machine produces Scrap Material
  MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine'})
  MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
  CREATE (machine)-[:PRODUCES_SCRAP {
    percentage: 5,
    description: 'Scrap from molding process'
  }]->(scrap);


  // Scrap Material also sent to replastauto for recycling
  MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
  MATCH (replastauto:Company {id: 'urn:ngsi-ld:Company:replastauto'})
  CREATE (scrap)-[:RECYCLED_BY ]->(replastauto);
// {
//     forRecycling: true,
//     // creditPerKg: 0.60,
//     description: 'Specialized recycling for 3D printing filament'
//   }

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
    printTime_h: 48,
    layerCount: 12500,
    energyConsumption_kWh: 2.5,
    materialUsed_kg: 2.5,
    co2Emissions_tCO2: 0.00125,
    co2EmissionsDescription: 'CO2 from energy use (0.5 kg CO2/kWh)'
  }]->(chair);

  // Chair has Scrap Material (closed loop!)
  MATCH (chair:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Chair'})
  MATCH (recycle:Material {id: 'urn:ngsi-ld:Material:RecyclePP'})
  CREATE (chair)-[:HAS_MATERIAL]->(recycle);

  MATCH (chair:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Chair'})
  MATCH (vergin:Material {id: 'urn:ngsi-ld:Material:PP'})
  CREATE (chair)-[:HAS_MATERIAL]->(vergin);


  // Chair produced by Circuprint
  MATCH (chair:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Chair'})
  MATCH (circuprint:Company {id: 'urn:ngsi-ld:Company:circuprint'})
  CREATE (chair)-[:PRODUCED_BY]->(circuprint);
