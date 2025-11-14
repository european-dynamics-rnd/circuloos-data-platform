// ========================================
// Verify Stock Levels After Production
// ========================================

// Check Siphon stock level
MATCH (siphon:ManufacturingComponent {id: 'urn:ngsi-ld:ManufacturingComponent:Siphon'})
RETURN 
  '=== SIPHON COMPONENT ===' as Title,
  siphon.name as ComponentName,
  siphon.stockLevel as CurrentStockLevel,
  'units' as Unit

UNION

// Check Thermolympic stock levels
MATCH (company:Company {id: 'urn:ngsi-ld:Company:thermolympic'})
RETURN 
  '=== THERMOLYMPIC - PP MATERIAL ===' as Title,
  company.name + ' - PP' as ComponentName,
  company.stockLevel_PP_kg as CurrentStockLevel,
  'kg' as Unit

UNION

MATCH (company:Company {id: 'urn:ngsi-ld:Company:thermolympic'})
RETURN 
  '=== THERMOLYMPIC - SCRAP PP MATERIAL ===' as Title,
  company.name + ' - Scrap PP' as ComponentName,
  company.stockLevel_ScrapPP_kg as CurrentStockLevel,
  'kg' as Unit

UNION

MATCH (company:Company {id: 'urn:ngsi-ld:Company:thermolympic'})
RETURN 
  '=== THERMOLYMPIC - RECYCLE PP MATERIAL ===' as Title,
  company.name + ' - Recycle PP' as ComponentName,
  company.stockLevel_RecyclePP_kg as CurrentStockLevel,
  'kg' as Unit

UNION

// Check Machine operating hours
MATCH (machine:InjectionMoldingMachine {id: 'urn:ngsi-ld:InjectionMoldingMachine'})
RETURN 
  '=== INJECTION MOLDING MACHINE ===' as Title,
  machine.name as ComponentName,
  machine.operatingHours as CurrentStockLevel,
  'hours' as Unit;
