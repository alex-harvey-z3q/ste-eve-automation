# Workflow overview

Start-of-booking (Provision):
1) Terraform apply -> creates isolated EVE VM for the booking
2) Deploy topology into EVE (YAML -> SDK/CLI)
3) If restore_state=true AND state exists -> restore device configs via Ansible network modules

End-of-booking (Teardown):
1) If save_state=true -> pull device configs and store as artifact (local example)
2) Terraform destroy -> removes the isolated EVE VM