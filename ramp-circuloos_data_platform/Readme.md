
# RAMP Marketplace and CIRCULOOS

The **RAMP Marketplace** is a key component of the CIRCULOOS ecosystem. It serves as:
- A community-building and data-sharing platform
- A hub for SMEs to access tools supporting circular economy initiatives
- The main entry point for onboarding new suppliers to CIRCULOOS

RAMP brings together manufacturers to collaborate on circular economy activities, such as:
- Selling products
- Making by-products available for reuse, upcycling, or recycling
- Fostering circular supply chains that benefit all participants, the economy, and the environment

RAMP is responsible for collecting user and organization information, which is used by other CIRCULOOS tools (e.g., production process descriptions for the SCOPT tool). The platform builds on the existing RAMP foundation, with new features added to meet CIRCULOOS business needs.

## How to Register Your Organization in RAMP

**Important:** For security, each CIRCULOOS Data Platform participant can only interact with tenants that start with their username.

**Step 1:** If you already created an organization in RAMP but did not follow the naming requirements below, please create a new one for your CIRCULOOS pilot activities.

**Step 2:** When registering, note that RAMP automatically adds the prefix `circuloos-` to your organization name. Your organization name must start with the remainder of your username (after `circuloos-`).

**Example:**
- Username: `circuloos-kostas-ed`
- Organization name in RAMP: `kostas-ed` (RAMP will store it as `circuloos_kostas_ed`)

This ensures your organization is correctly linked to your CIRCULOOS identity and can interact with the platform as required.



## Video Tutorials: Using RAMP with CIRCULOOS

The following video tutorials demonstrate how to use the RAMP Marketplace in the context of the CIRCULOOS platform:

- [Part 1](./CIRCULOOS%20Data%20platform%20RAMP-part1.mp4): How to create an organization and a new sell ad in RAMP.eu.
- [Part 2](./CIRCULOOS%20Data%20platform%20RAMP-part2.mp4): How to create a sell ad using a POST request to the CIRCULOOS data platform.

### Example Files Used in the Tutorials

- `material_1.json`: Example items created via the RAMP.eu GUI and sent by RAMP.eu to the CIRCULOOS data platform.
- `material_2.json`: Example items sent directly to the CIRCULOOS data platform using the command:
	```bash
	./addDataOrionViaKong.sh circuloos_kostas_ed_material material_2.json
	```

Both materials (in the order above) are part of the RAMP.eu [supply chain](https://ramp.eu/#/service-request/supply-chain) workflow.
