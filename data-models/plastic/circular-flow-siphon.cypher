// ========================================
// Circular Economy Flow for Siphon Production
// Shows: Virgin PP -> Siphon -> Scrap PP -> Recycled PP -> Siphon
// 
// USAGE:
// 1. Run this query in Neo4j Browser
// 2. Click "Graph" tab to see visual graph
// 3. Click "Table" tab to see detailed metrics
// ========================================

// Start with Virgin PP Material
MATCH (pp:Material {id: 'urn:ngsi-ld:Material:PP'})

// Virgin PP supplied by company
OPTIONAL MATCH path1 = (pp)-[supply:SUPPLIED_BY]->(supplier:Company)

// Virgin PP used in Siphon
MATCH path2 = (siphon:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})-[hasPP:HAS_MATERIAL]->(pp)

// Siphon produced by Thermolympic
MATCH path3 = (siphon)-[produced:PRODUCED_BY]->(manufacturer:Company)

// Machine owned by manufacturer
MATCH path4 = (machine:InjectionMoldingMachine)-[owned:OWNED_BY]->(manufacturer)

// Machine makes Siphon
MATCH path5 = (machine)-[makes:MAKES]->(siphon)

// Machine produces Scrap PP
MATCH path6 = (machine)-[producesScrap:PRODUCES_SCRAP]->(scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})

// Scrap PP recycled by companies
OPTIONAL MATCH path7 = (scrap)-[recycled:RECYCLED_BY]->(recycler:Company)

// Recycle PP supplied by recycler
MATCH path8 = (recyclePP:Material {id: 'urn:ngsi-ld:Material:RecyclePP'})-[supplyRecycle:SUPPLIED_BY]->(recycleSupplier:Company)

// Recycle PP used in Siphon (closing the loop!)
MATCH path9 = (siphon)-[hasRecycle:HAS_MATERIAL]->(recyclePP)

RETURN 
  // Return paths for graph visualization
  path1, path2, path3, path4, path5, path6, path7, path8, path9,
  
  // Return detailed metrics for table view
  '=== CIRCULAR ECONOMY FLOW FOR SIPHON ===' as Title,
  '1. VIRGIN MATERIAL' as Step1,
  pp.name as VirginMaterial,
  supplier.name as VirginSupplier,
  supply.transportDistance_km as SupplyDistance_km,
  supply.co2Transport_tCO2 as SupplyCO2_tCO2,
  
  '2. PRODUCTION' as Step2,
  siphon.name as Product,
  manufacturer.name as Manufacturer,
  machine.name as Machine,
  makes.energyConsumption_kWh as ProductionEnergy_kWh,
  makes.co2Emissions_tCO2 as ProductionCO2_tCO2,
  
  '3. SCRAP GENERATION' as Step3,
  scrap.name as ScrapMaterial,
  producesScrap.percentage as ScrapPercentage,
  scrap.carbonFootprint as ScrapCarbonFootprint_kgCO2perKg,
  
  '4. RECYCLING' as Step4,
  collect(DISTINCT recycler.name) as RecyclingCompanies,
  recyclePP.name as RecycledMaterial,
  recyclePP.carbonFootprint as RecycledCarbonFootprint_kgCO2perKg,
  
  '5. CIRCULAR LOOP CLOSED' as Step5,
  'Recycled PP returns to Siphon production' as CircularityAchieved,
  (pp.carbonFootprint - recyclePP.carbonFootprint) as CO2Saved_perKg,
  ((pp.carbonFootprint - recyclePP.carbonFootprint) / pp.carbonFootprint * 100) as CO2Reduction_Percent;
