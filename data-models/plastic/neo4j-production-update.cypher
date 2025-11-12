// ========================================
// CIRCULOOS Plastic Manufacturing - Production Simulation
// Produce 100 pieces of Siphon and update stock levels
// ========================================

// Production parameters
WITH 100 as productionQty,
     0.10 as materialPerSiphon_kg,  // PP material per siphon
     0.05 as scrapPerSiphon_kg,     // Scrap PP material per siphon
     0.055 as energyPerCycle_kWh,   // Energy consumption per cycle
     45 as cycleTime_seconds,       // Cycle time in seconds
     2 as moldingCycles             // Molding cycles per siphon

// Calculate totals
WITH productionQty, materialPerSiphon_kg, scrapPerSiphon_kg, 
     energyPerCycle_kWh, cycleTime_seconds, moldingCycles,
     (materialPerSiphon_kg * productionQty) as totalPP_needed,
     (scrapPerSiphon_kg * productionQty) as totalScrap_needed,
     (productionQty * 0.005) as scrapGenerated_kg,  // 5% scrap generation
     (energyPerCycle_kWh * moldingCycles * productionQty) as totalEnergy_kWh,
     ((cycleTime_seconds * moldingCycles * productionQty) / 3600.0) as totalProductionTime_hours,
     (energyPerCycle_kWh * moldingCycles * productionQty * 0.5 / 1000) as totalCO2_production_tCO2

// ========================================
// 1. UPDATE SIPHON STOCK LEVEL (Increase by 100)
// ========================================
MATCH (siphon:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})
SET siphon.stockLevel = siphon.stockLevel + productionQty,
    siphon.lastTimeUsed = datetime().epochMillis

// ========================================
// 2. UPDATE PP MATERIAL STOCK LEVEL (Decrease)
// ========================================
WITH siphon, productionQty, totalPP_needed, totalScrap_needed, 
     scrapGenerated_kg, totalEnergy_kWh, totalProductionTime_hours, 
     totalCO2_production_tCO2
MATCH (pp:Material {id: 'urn:ngsi-ld:Material:PP'})
SET pp.stockLevel = pp.stockLevel - totalPP_needed

// ========================================
// 3. UPDATE SCRAP PP MATERIAL STOCK LEVEL (Decrease usage, Increase from production)
// ========================================
WITH siphon, pp, productionQty, totalPP_needed, totalScrap_needed, 
     scrapGenerated_kg, totalEnergy_kWh, totalProductionTime_hours, 
     totalCO2_production_tCO2
MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
SET scrap.stockLevel = scrap.stockLevel - totalScrap_needed + scrapGenerated_kg

// ========================================
// 4. UPDATE MACHINE OPERATING HOURS
// ========================================
WITH siphon, pp, scrap, productionQty, totalPP_needed, totalScrap_needed, 
     scrapGenerated_kg, totalEnergy_kWh, totalProductionTime_hours, 
     totalCO2_production_tCO2
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine'})
SET machine.operatingHours = machine.operatingHours + totalProductionTime_hours

// ========================================
// 5. RETURN PRODUCTION SUMMARY
// ========================================
RETURN 
  '=== PRODUCTION SUMMARY ===' as Section1,
  productionQty as UnitsProduced,
  siphon.stockLevel as NewSiphonStockLevel,
  '=== MATERIAL CONSUMPTION ===' as Section2,
  totalPP_needed as PP_Consumed_kg,
  pp.stockLevel as NewPP_StockLevel_kg,
  totalScrap_needed as ScrapPP_Consumed_kg,
  scrapGenerated_kg as ScrapPP_Generated_kg,
  scrap.stockLevel as NewScrapPP_StockLevel_kg,
  '=== PRODUCTION METRICS ===' as Section3,
  totalProductionTime_hours as TotalProductionTime_hours,
  machine.operatingHours as NewMachineOperatingHours,
  totalEnergy_kWh as TotalEnergyConsumed_kWh,
  totalCO2_production_tCO2 as TotalCO2_Emissions_tCO2,
  '=== MATERIAL BALANCE ===' as Section4,
  (totalPP_needed + totalScrap_needed) as TotalMaterialInput_kg,
  (productionQty * 0.15) as TotalMaterialInProducts_kg,
  scrapGenerated_kg as ScrapOutput_kg,
  '=== TIMESTAMP ===' as Section5,
  datetime().epochMillis as ProductionTimestamp_ms,
  toString(datetime()) as ProductionDateTime;
