#!/bin/bash

# requirements:
# - yq >= 4.27.1
# - csv2md (`pip install`)

SCRIPT_DIR=$( realpath "$( dirname "${BASH_SOURCE[0]}")")
. "$SCRIPT_DIR/common.sh"

main() {
  print_markdown
}

print_markdown() {
  echo "# Tasks"
  for f in "$TASKS_DIR"/*.yml; do
#    if [ "$(basename "$f")" == "echo.yml" ]; then
    if [ "$(basename "$f")" != "kustomization.yml" ]; then
      name="$(yq '.metadata.name' "$f")"

      echo -e "\n## $name\n"
      yq '.spec.description' "$f"

      print_params "$f"
      print_results "$f"
      print_workspaces "$f"
    fi
  done
}

main "$@"
