# ste-eve-automation

Example project showing:
- AAP orchestrates Terraform to provision an isolated EVE VM per booking
- EVE topology deployed from YAML (via SDK/CLI wrapper)
- Optional save_state / restore_state controlled by booking inputs (survey)

## AAP entrypoints
- aap/start_booking.yml
- aap/end_booking.yml

## Booking inputs
See docs/survey_spec.md
