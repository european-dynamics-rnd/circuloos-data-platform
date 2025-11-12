// ========================================
// Verify Stock Levels After Production
// ========================================

// Check Siphon stock level
MATCH (siphon:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})
RETURN 
  '=== SIPHON COMPONENT ===' as Title,
  siphon.name as ComponentName,
  siphon.stockLevel as CurrentStockLevel,
  toString(siphon.lastTimeUsed) as Unit

UNION

// Check PP Material stock level
MATCH (pp:Material {id: 'urn:ngsi-ld:Material:PP'})
RETURN 
  '=== PP MATERIAL ===' as Title,
  pp.name as ComponentName,
  pp.stockLevel as CurrentStockLevel,
  'kg' as Unit

UNION

// Check Scrap PP Material stock level
MATCH (scrap:Material {id: 'urn:ngsi-ld:Material:ScrapPP'})
RETURN 
  '=== SCRAP PP MATERIAL ===' as Title,
  scrap.name as ComponentName,
  scrap.stockLevel as CurrentStockLevel,
  'kg' as Unit

UNION

// Check Machine operating hours
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine'})
RETURN 
  '=== INJECTION MOLDING MACHINE ===' as Title,
  machine.name as ComponentName,
  machine.operatingHours as CurrentStockLevel,
  'hours' as Unit;
