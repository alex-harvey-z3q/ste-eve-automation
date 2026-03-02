#!/usr/bin/env bash

set -euo pipefail

readonly PROG_NAME="$(basename "$0")"

usage() {
  cat <<EOF
Usage:
  ${PROG_NAME} --eve <ip-or-host> --topology <file.yml> --lab-name <name>

Arguments:
  --eve        EVE-NG IP/hostname (e.g. 10.0.0.12)
  --topology   Path to topology YAML file (e.g. topologies/hello-world.yml)
  --lab-name   Name to assign the lab (e.g. booking-123)

Example:
  ${PROG_NAME} --eve 10.0.0.12 --topology topologies/hello-world.yml --lab-name booking-123
EOF
}

die() {
  # Usage: die "message" [exit_code]
  local -r msg="$1"
  local -r code="${2:-1}"
  echo "ERROR: ${msg}" >&2
  exit "${code}"
}

require_command() {
  local -r cmd="$1"
  command -v "${cmd}" >/dev/null 2>&1 || die "Required command not found in PATH: ${cmd}" 127
}

parse_args() {
  # Outputs (globals): EVE_HOST, TOPOLOGY_FILE, LAB_NAME
  EVE_HOST=""
  TOPOLOGY_FILE=""
  LAB_NAME=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --eve)
        [[ $# -ge 2 ]] || die "--eve requires a value" 2
        EVE_HOST="$2"
        shift 2
        ;;
      --topology)
        [[ $# -ge 2 ]] || die "--topology requires a value" 2
        TOPOLOGY_FILE="$2"
        shift 2
        ;;
      --lab-name)
        [[ $# -ge 2 ]] || die "--lab-name requires a value" 2
        LAB_NAME="$2"
        shift 2
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        usage >&2
        die "Unknown argument: $1" 2
        ;;
    esac
  done

  [[ -n "${EVE_HOST}" ]] || die "Missing required argument: --eve" 2
  [[ -n "${TOPOLOGY_FILE}" ]] || die "Missing required argument: --topology" 2
  [[ -n "${LAB_NAME}" ]] || die "Missing required argument: --lab-name" 2
}

validate_inputs() {
  [[ -f "${TOPOLOGY_FILE}" ]] || die "Topology file not found: ${TOPOLOGY_FILE}" 2
}

deploy() {
  require_command "evengology"

  echo "Deploying topology via evengology:"
  echo "  EVE host:  ${EVE_HOST}"
  echo "  Topology:  ${TOPOLOGY_FILE}"
  echo "  Lab name:  ${LAB_NAME}"

  # Adjust flags as needed for your environment (auth, port, etc.).
  evengology deploy --host "${EVE_HOST}" --file "${TOPOLOGY_FILE}" --name "${LAB_NAME}"

  echo "Deployment complete."
}

main() {
  parse_args "$@"
  validate_inputs
  deploy
}

main "$@"
