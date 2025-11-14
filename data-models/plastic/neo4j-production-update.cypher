// ========================================
// CIRCULOOS Plastic Manufacturing - Production Simulation
// Produce 100 pieces of Siphon and update stock levels
// ========================================

// Get production parameters from graph
MATCH (siphon:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine'})
MATCH (machine)-[scrapRel:PRODUCES_SCRAP]->(scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
MATCH (machine)-[makes:MAKES]->(siphon)
MATCH (virgin:Material {id: 'urn:ngsi-ld:Material:PP'})
MATCH (virgin)-[supplyVirgin:SUPPLIED_BY]->(supplierVirgin:Company)
MATCH (recycle:Material {id: 'urn:ngsi-ld:Material:RecyclePP'})
MATCH (recycle)-[supplyRecycle:SUPPLIED_BY]->(supplierRecycle:Company)
WHERE supplyVirgin.priority = 1 AND supplyRecycle.priority = 1

// Production parameters from graph
WITH 100 as productionQty,
     0.50 as virginPercentage,  // <-- CHANGE THIS VALUE (0.0 to 1.0) - Virgin PP percentage
     siphon.rawMaterialPerPart_kg as materialPerSiphon_kg,  // PP material per siphon (from graph)
     (scrapRel.percentage / 100.0 * siphon.rawMaterialPerPart_kg) as scrapPerSiphon_kg,  // Scrap PP material per siphon (calculated from graph)
     makes.totalProductionTime as totalProductionTime_seconds,  // Total production time per siphon (from graph)
     siphon, machine, makes, virgin, recycle, supplyVirgin, supplyRecycle

// Calculate totals
WITH productionQty, materialPerSiphon_kg, scrapPerSiphon_kg, 
     totalProductionTime_seconds, virginPercentage,
     siphon, machine, makes, virgin, recycle, supplyVirgin, supplyRecycle,
     (1.0 - virginPercentage) as recycledPercentage,
     (materialPerSiphon_kg * virginPercentage * productionQty) as totalPP_needed,
     (materialPerSiphon_kg * (1.0 - virginPercentage) * productionQty) as totalRecycle_needed,
     (productionQty * materialPerSiphon_kg * 0.05) as scrapGenerated_kg,  // 5% scrap generation (calculated from material)
     (makes.energyConsumption_kWh * productionQty) as totalEnergy_kWh,
     ((totalProductionTime_seconds * productionQty) / 3600.0) as totalProductionTime_hours,
     (makes.energyConsumption_kWh * productionQty * 0.5 / 1000) as totalCO2_production_tCO2

// Calculate material-specific CO2
WITH productionQty, materialPerSiphon_kg, scrapPerSiphon_kg, 
     totalProductionTime_seconds, virginPercentage, recycledPercentage,
     siphon, machine, makes, virgin, recycle, supplyVirgin, supplyRecycle,
     totalPP_needed, totalRecycle_needed, scrapGenerated_kg, 
     totalEnergy_kWh, totalProductionTime_hours, totalCO2_production_tCO2,
     // Virgin material CO2
     (virgin.carbonFootprint * totalPP_needed / 1000) as virginMaterialCO2_tCO2,
     (supplyVirgin.co2Transport_tCO2 * virginPercentage * productionQty) as virginTransportCO2_tCO2,
     // Recycled material CO2
     (recycle.carbonFootprint * totalRecycle_needed / 1000) as recycleMaterialCO2_tCO2,
     (supplyRecycle.co2Transport_tCO2 * recycledPercentage * productionQty) as recycleTransportCO2_tCO2

// Calculate total CO2
WITH productionQty, materialPerSiphon_kg, virginPercentage, recycledPercentage,
     siphon, machine, makes,
     totalPP_needed, totalRecycle_needed, scrapGenerated_kg, 
     totalEnergy_kWh, totalProductionTime_hours, totalCO2_production_tCO2,
     virginMaterialCO2_tCO2, virginTransportCO2_tCO2,
     recycleMaterialCO2_tCO2, recycleTransportCO2_tCO2,
     (virginMaterialCO2_tCO2 + virginTransportCO2_tCO2 + 
      recycleMaterialCO2_tCO2 + recycleTransportCO2_tCO2 + 
      totalCO2_production_tCO2) as totalCO2_tCO2

// ========================================
// 1. UPDATE SIPHON STOCK LEVEL (Increase by 100)
// ========================================
// Update siphon stock level
SET siphon.stockLevel = siphon.stockLevel + productionQty,
    siphon.lastTimeUsed = datetime().epochMillis

// ========================================
// 2. UPDATE THERMOLYMPIC COMPANY STOCK LEVELS
// ========================================
WITH siphon, machine, productionQty, virginPercentage, recycledPercentage,
     totalPP_needed, totalRecycle_needed, 
     scrapGenerated_kg, totalEnergy_kWh, totalProductionTime_hours, 
     totalCO2_production_tCO2, totalCO2_tCO2,
     virginMaterialCO2_tCO2, virginTransportCO2_tCO2,
     recycleMaterialCO2_tCO2, recycleTransportCO2_tCO2,
     materialPerSiphon_kg
MATCH (company:Company {id: 'urn:ngsi-ld:Company:thermolympic'})
// Decrease PP stock (virgin material consumed)
// Decrease RecyclePP stock (recycled material consumed)
// Increase ScrapPP stock (scrap generated from production)
SET company.stockLevel_PP_kg = company.stockLevel_PP_kg - totalPP_needed,
    company.stockLevel_RecyclePP_kg = company.stockLevel_RecyclePP_kg - totalRecycle_needed,
    company.stockLevel_ScrapPP_kg = company.stockLevel_ScrapPP_kg + scrapGenerated_kg

// ========================================
// 3. UPDATE MACHINE OPERATING HOURS
// ========================================
WITH siphon, company, productionQty, virginPercentage, recycledPercentage,
     totalPP_needed, totalRecycle_needed, 
     scrapGenerated_kg, totalEnergy_kWh, totalProductionTime_hours, 
     totalCO2_production_tCO2, totalCO2_tCO2,
     virginMaterialCO2_tCO2, virginTransportCO2_tCO2,
     recycleMaterialCO2_tCO2, recycleTransportCO2_tCO2,
     machine, materialPerSiphon_kg
// Update machine operating hours
SET machine.operatingHours = machine.operatingHours + totalProductionTime_hours

// ========================================
// 4. RETURN PRODUCTION SUMMARY
// ========================================
RETURN 
  '=== MATERIAL COMPOSITION ===' as Section0,
  (virginPercentage * 100) as VirginPP_Percent,
  (recycledPercentage * 100) as RecycledPP_Percent,
  '=== PRODUCTION SUMMARY ===' as Section1,
  productionQty as UnitsProduced,
  siphon.stockLevel as NewSiphonStockLevel,
  '=== MATERIAL CONSUMPTION ===' as Section2,
  totalPP_needed as VirginPP_Consumed_kg,
  company.stockLevel_PP_kg as NewVirginPP_StockLevel_kg,
  totalRecycle_needed as RecyclePP_Consumed_kg,
  company.stockLevel_RecyclePP_kg as NewRecyclePP_StockLevel_kg,
  scrapGenerated_kg as ScrapPP_Generated_kg,
  company.stockLevel_ScrapPP_kg as NewScrapPP_StockLevel_kg,
  '=== PRODUCTION METRICS ===' as Section3,
  totalProductionTime_hours as TotalProductionTime_hours,
  machine.operatingHours as NewMachineOperatingHours,
  totalEnergy_kWh as TotalEnergyConsumed_kWh,
  '=== CO2 EMISSIONS BREAKDOWN ===' as Section4,
  virginMaterialCO2_tCO2 as VirginMaterial_CO2_tCO2,
  virginTransportCO2_tCO2 as VirginTransport_CO2_tCO2,
  recycleMaterialCO2_tCO2 as RecycledMaterial_CO2_tCO2,
  recycleTransportCO2_tCO2 as RecycledTransport_CO2_tCO2,
  totalCO2_production_tCO2 as Manufacturing_CO2_tCO2,
  totalCO2_tCO2 as TotalCO2_Emissions_tCO2,
  '=== MATERIAL BALANCE ===' as Section5,
  (totalPP_needed + totalRecycle_needed) as TotalMaterialInput_kg,
  (productionQty * materialPerSiphon_kg) as TotalMaterialInProducts_kg,
  scrapGenerated_kg as ScrapOutput_kg,
  '=== TIMESTAMP ===' as Section6,
  datetime().epochMillis as ProductionTimestamp_ms,
  toString(datetime()) as ProductionDateTime;
