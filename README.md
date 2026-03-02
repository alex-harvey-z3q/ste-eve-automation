# ste-eve-automation

Example project showing:
- AAP orchestrates Terraform to provision an isolated EVE VM per booking
- EVE topology deployed from YAML (via SDK/CLI wrapper)
- Optional save_state / restore_state controlled by booking inputs (survey)

## Architecture

```
                           (Start booking)                     (End booking)
ServiceNow / Booking Form  ----------------->  AAP Workflow  ----------------->  AAP Workflow
  - booking_id                                   (provision)                     (teardown)
  - topology_file
  - restore_state?                                                             - save_state?
  - save_state?                                                               - terraform destroy
        |
        v
+------------------------------------------------------------------------------------------+
|                                Control / Orchestration Layer                             |
|                                                                                          |
|   AAP runs:                                                                              |
|     1) Terraform apply  ---> provisions an isolated EVE-NG VM per booking                |
|     2) Deploy topology  ---> EVE SDK/CLI builds lab from YAML inside that EVE VM         |
|     3) Optional restore ---> if restore_state=true, push saved configs to devices        |
|                                                                                          |
|   At end of booking:                                                                     |
|     4) Optional save    ---> if save_state=true, pull configs from devices and store     |
|     5) Terraform destroy ---> deletes the EVE VM (no shared state, no collisions)        |
+------------------------------------------------------------------------------------------+

                                  vSphere / Hypervisor Layer
                        +------------------------------------------+
                        |  One VM per booking (resource isolated)  |
                        |                                          |
                        |   +-------------------------------+      |
                        |   | EVE-NG VM (single-user)       |      |
                        |   |  - runs QEMU nodes            |      |
                        |   |  - hosts the lab topology     |      |
                        |   +-------------------------------+      |
                        |                |                         |
                        |                v                         |
                        |        +---------------+                 |
                        |        | Cisco nodes   |  (IOSv/CSR/etc) |
                        |        +---------------+                 |
                        +------------------------------------------+

                           Durable Storage (state artifacts)
                        +------------------------------------------+
                        | state/<booking_id>/                      |
                        |  - r1.running.cfg                        |
                        |  - r2.running.cfg                        |
                        |  - manifest.json                         |
                        +------------------------------------------+
```

## AAP entrypoints
- aap/start_booking.yml
- aap/end_booking.yml

## Booking inputs
See docs/survey_spec.md
