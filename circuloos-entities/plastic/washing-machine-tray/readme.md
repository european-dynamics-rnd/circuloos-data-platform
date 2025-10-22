# Description

The following is for the implementation in a simple form of a digital twin an product by THERMOLYMPIC, washing machine tray.

The main entity is the urn:ngsi-ld:ManufacturingMachine:washingMachineTray:001, which represent the final product. The product consist of several other parts, subassemvlies
- urn:ngsi-ld:ManufacturingComponent:lid:001
- urn:ngsi-ld:ManufacturingComponent:distributor:001
- urn:ngsi-ld:ManufacturingComponent:fixedTub:001
- urn:ngsi-ld:ManufacturingComponent:slidingTub:001
- urn:ngsi-ld:ManufacturingComponent:siphon:001
- urn:ngsi-ld:ManufacturingComponent:metalClamp:001
- urn:ngsi-ld:ManufacturingComponent:pipeTub:001


Each sub-assembly has several attributes:

- **name** (Property): Human-readable name of the component (e.g., "Lid", "Distributor", "Siphon")
- **energyConsumption** (Property): Energy required to manufacture the component, measured in kilowatt-hours (KWH)
- **weight** (Property): Weight of the component in kilograms (KGM)
- **hasMaterial** (Relationship): Links to the Material entity that the component is made from (e.g., PP, PP+50%CO3Ca, aluminum)
- **warehouseLocation** (Relationship): References the Warehouse entity where the component is stored
- **producedBy** (Relationship): Links to the Company entity that manufactures this component
- **stockLevel** (Property): Current inventory quantity available in the warehouse
- **lastTimeUsed** (Property): Timestamp (DateTime) indicating when the component was last used in production

## Manufacturing Relationships

When the **producedBy** relationship points to `urn:ngsi-ld:Company:thermolympic`, it indicates that Thermolympic manufactures that specific sub-assembly in-house. Components produced by other companies (e.g., `urn:ngsi-ld:Company:aluminext` for metal parts) are sourced externally.

## Order Processing Workflow

When a new production order is received (e.g., 100 units of `urn:ngsi-ld:ManufacturingMachine:washingMachineTray:001`), the system executes the following digital twin workflow:

### 1. **Inventory Check**
   - Query each sub-assembly's **stockLevel** attribute
   - Compare current stock against required quantity (100 pieces per component)
   - Identify components with insufficient stock

### 2. **Material Requirements Calculation**
   - For each component needing production:
     - Follow the **hasMaterial** relationship to identify required raw materials
     - Retrieve the component's **weight** attribute
     - Calculate total material needed: `component_weight × quantity_to_produce`
   - Aggregate material requirements across all components

### 3. **Raw Material Availability Check**
   - For each required material entity:
     - Check the material's **stockLevel** attribute (measured in kg)
     - Compare available quantity against calculated requirements
   - If material stock is insufficient:
     - Follow the **supplier** relationship to retrieve list of potential suppliers
     - Generate procurement request with:
       - Material specification
       - Required quantity (in kg)
       - List of qualified suppliers
     - Forward request to the **Supply Chain Optimization Tool** for automated sourcing

### 4. **Production Scheduling**
   - Calculate total **energyConsumption** for the production run
   - Verify component **warehouseLocation** for logistics planning
   - Update **lastTimeUsed** timestamp when production begins
   - Decrement **stockLevel** for consumed materials and components

## Digital Twin Benefits

This entity model enables:
- **Real-time inventory tracking** across components and materials
- **Automated material procurement** when stock levels are low
- **Energy consumption forecasting** based on production orders
- **Supply chain optimization** through multi-supplier relationships
- **Traceability** via warehouse locations and production timestamps