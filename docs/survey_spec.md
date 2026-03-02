# Booking inputs (AAP Survey / ServiceNow form)

Required:
- booking_id (string): Unique booking identifier (e.g. SNOW RITM, UUID)
- topology_file (string): Path or identifier for topology (e.g. topologies/sdwan.yml)
- eve_ip (string, optional): If you cannot reliably discover EVE VM IP from Terraform outputs, pass it in.

Optional state controls:
- restore_state (boolean): If true, and a saved state artifact exists for this booking_id, restore configs after topology deploy.
- save_state (boolean): If true, save device configs before tearing down the EVE VM at end of booking.

Notes:
- restore_state should run AFTER: provision EVE VM, deploy topology, devices reachable.
- save_state should run BEFORE: terraform destroy.