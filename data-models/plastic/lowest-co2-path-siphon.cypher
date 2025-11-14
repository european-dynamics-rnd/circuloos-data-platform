// ========================================
// Find Lowest CO2 Path for Siphon Production
// Compares different material sourcing options and recycling paths
// ========================================

// ========================================
// OPTION 1: Virgin PP from rawplasticsa
// ========================================
MATCH (pp:Material {id: 'urn:ngsi-ld:Material:PP'})
MATCH (pp)-[supply1:SUPPLIED_BY {priority: 1}]->(supplier1:Company {id: 'urn:ngsi-ld:Company:rawplasticsa'})
MATCH (siphon:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})-[:HAS_MATERIAL]->(pp)
MATCH (machine:InjectionMoldingMachine)-[makes:MAKES]->(siphon)
WITH 
  'Virgin PP from rawplasticsa' as Option,
  pp.carbonFootprint as materialCO2_kgPerKg,
  supply1.co2Transport_tCO2 as transportCO2_tCO2,
  supply1.transportDistance_km as distance_km,
  makes.co2Emissions_tCO2 as productionCO2_tCO2,
  siphon.rawMaterialPerPart_kg as materialPerPart_kg,
  (pp.carbonFootprint * siphon.rawMaterialPerPart_kg / 1000) as materialCO2_tCO2
WITH Option, distance_km, materialCO2_kgPerKg, 
     (materialCO2_tCO2 + transportCO2_tCO2 + productionCO2_tCO2) as totalCO2_tCO2,
     materialCO2_tCO2, transportCO2_tCO2, productionCO2_tCO2

RETURN Option, distance_km, materialCO2_kgPerKg,
       materialCO2_tCO2, transportCO2_tCO2, productionCO2_tCO2, totalCO2_tCO2
ORDER BY totalCO2_tCO2 ASC

UNION

// ========================================
// OPTION 2: Virgin PP from iberoplast
// ========================================
MATCH (pp:Material {id: 'urn:ngsi-ld:Material:PP'})
MATCH (pp)-[supply2:SUPPLIED_BY {priority: 2}]->(supplier2:Company {id: 'urn:ngsi-ld:Company:iberoplast'})
MATCH (siphon:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})-[:HAS_MATERIAL]->(pp)
MATCH (machine:InjectionMoldingMachine)-[makes:MAKES]->(siphon)
WITH 
  'Virgin PP from iberoplast' as Option,
  pp.carbonFootprint as materialCO2_kgPerKg,
  supply2.co2Transport_tCO2 as transportCO2_tCO2,
  supply2.transportDistance_km as distance_km,
  makes.co2Emissions_tCO2 as productionCO2_tCO2,
  siphon.rawMaterialPerPart_kg as materialPerPart_kg,
  (pp.carbonFootprint * siphon.rawMaterialPerPart_kg / 1000) as materialCO2_tCO2
WITH Option, distance_km, materialCO2_kgPerKg,
     (materialCO2_tCO2 + transportCO2_tCO2 + productionCO2_tCO2) as totalCO2_tCO2,
     materialCO2_tCO2, transportCO2_tCO2, productionCO2_tCO2

RETURN Option, distance_km, materialCO2_kgPerKg,
       materialCO2_tCO2, transportCO2_tCO2, productionCO2_tCO2, totalCO2_tCO2
ORDER BY totalCO2_tCO2 ASC

UNION

// ========================================
// OPTION 3: Recycled PP from Lollo
// ========================================
MATCH (recyclePP:Material {id: 'urn:ngsi-ld:Material:RecyclePP'})
MATCH (recyclePP)-[supplyRecycle:SUPPLIED_BY]->(lollo:Company {id: 'urn:ngsi-ld:Company:lollo'})
MATCH (siphon:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})-[:HAS_MATERIAL]->(recyclePP)
MATCH (machine:InjectionMoldingMachine)-[makes:MAKES]->(siphon)
MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})-[recycled:RECYCLED_BY]->(lollo)
WITH 
  'Recycled PP from Lollo' as Option,
  recyclePP.carbonFootprint as materialCO2_kgPerKg,
  supplyRecycle.co2Transport_tCO2 as transportCO2_tCO2,
  supplyRecycle.transportDistance_km as distance_km,
  makes.co2Emissions_tCO2 as productionCO2_tCO2,
  siphon.rawMaterialPerPart_kg as materialPerPart_kg,
  recycled.co2Emissions_tCO2 as recyclingCO2_tCO2,
  recycled.co2Transport_tCO2 as recyclingTransportCO2_tCO2,
  (recyclePP.carbonFootprint * siphon.rawMaterialPerPart_kg / 1000) as materialCO2_tCO2
WITH Option, distance_km, materialCO2_kgPerKg,
     (materialCO2_tCO2 + transportCO2_tCO2 + productionCO2_tCO2 + recyclingCO2_tCO2 + recyclingTransportCO2_tCO2) as totalCO2_tCO2,
     materialCO2_tCO2, transportCO2_tCO2, productionCO2_tCO2

RETURN Option, distance_km, materialCO2_kgPerKg,
       materialCO2_tCO2, transportCO2_tCO2, productionCO2_tCO2, totalCO2_tCO2
ORDER BY totalCO2_tCO2 ASC

UNION

// ========================================
// OPTION 4: Recycled PP from Circuprint (Local/On-site)
// ========================================
MATCH (recyclePP:Material {id: 'urn:ngsi-ld:Material:RecyclePP'})
MATCH (recyclePP)-[supplyRecycle:SUPPLIED_BY]->(circuprint:Company {id: 'urn:ngsi-ld:Company:circuprint'})
MATCH (siphon:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})-[:HAS_MATERIAL]->(recyclePP)
MATCH (machine:InjectionMoldingMachine)-[makes:MAKES]->(siphon)
MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})-[recycled:RECYCLED_BY]->(circuprint)
WITH 
  'Recycled PP from Circuprint (LOCAL)' as Option,
  recyclePP.carbonFootprint as materialCO2_kgPerKg,
  supplyRecycle.co2Transport_tCO2 as transportCO2_tCO2,
  supplyRecycle.transportDistance_km as distance_km,
  makes.co2Emissions_tCO2 as productionCO2_tCO2,
  siphon.rawMaterialPerPart_kg as materialPerPart_kg,
  recycled.co2Emissions_tCO2 as recyclingCO2_tCO2,
  recycled.co2Transport_tCO2 as recyclingTransportCO2_tCO2,
  (recyclePP.carbonFootprint * siphon.rawMaterialPerPart_kg / 1000) as materialCO2_tCO2
WITH Option, distance_km, materialCO2_kgPerKg,
     (materialCO2_tCO2 + transportCO2_tCO2 + productionCO2_tCO2 + recyclingCO2_tCO2 + recyclingTransportCO2_tCO2) as totalCO2_tCO2,
     materialCO2_tCO2, transportCO2_tCO2, productionCO2_tCO2

RETURN Option, distance_km, materialCO2_kgPerKg,
       materialCO2_tCO2, transportCO2_tCO2, productionCO2_tCO2, totalCO2_tCO2
ORDER BY totalCO2_tCO2 ASC;
