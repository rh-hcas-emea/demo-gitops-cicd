# allows me to check if yq failed in the pipe sequence, otherwise csv2md always "succeeds"
set -o pipefail

PROJECT_DIR="$(realpath "$SCRIPT_DIR/../")"
CICD_DIR="$PROJECT_DIR/cicd"
TASKS_DIR="$CICD_DIR/tasks"
PIPELINES_DIR="$CICD/pipelines"

print_params() {
  local file="$1"; shift
  yq_md '\n### Parameters' \
    '.spec.params' \
    '"Name", "Type", "Default", "Description"' \
    '.name, .type, .default | @json // "", .description // ""' \
    "$file"
}

print_results() {
  local file="$1"; shift
  yq_md '### Results' \
    '.spec.results' \
    '"Name", "Description"' \
    '.name, .description' \
    "$file"
}

print_workspaces() {
  local file="$1"; shift
  yq_md '### Workspaces' \
    '.spec.workspaces' \
    '"Name", "Optional", "Read-Only", "Description"' \
    '.name, .optional // false, .readOnly // false, .description' \
    "$file"
}

yq_md() {
  local title="$1"; shift
  local field="$1"; shift
  local head="$1"; shift
  local cols="$1"; shift
  local file="$1"; shift

  # extract yaml array into csv table
  # the grep removes any trailing empty lines to allow `wc -l` to work more accurately
  local output="$(yq "[[$head]] + [$field[] | [$cols]]" "$file" -o csv 2>/dev/null | grep -ve '^$')"

  # convert arrays printed as a json string to appear better in markdown
  # - """ becomes `
  # - "[ becomes "`[
  # - ]" become ]`"
  # - [] becomes `[]`
  local output="$(echo "$output" | sed -r 's/"""/`/g;s/"\[/"`[/g;s/\]"/]`"/g;s/,\[\],/,`[]`,/g')"

  # don't print if there is no data
  # there will always be one line
  if [[ $(echo "$output" | wc -l) > 1 ]]; then
    echo -e "$title\n"
    echo -e "$(echo "$output" | csv2md)\n"
  fi
}
