#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$(realpath "$SCRIPT_DIR/../")

app_name=greeting-ui
git_url=git@github.com:tom-stockwell/greeting-ui-k8s.git
image_url=quay.io/tstockwell/greeting-ui
image_tag=latest

tkn pipeline start deploy --use-param-defaults \
  -w name=scratch,emptyDir="" \
  -w name=source,volumeClaimTemplateFile="${PROJECT_DIR}"/volume-claim-template.yml \
  -p app-name=$app_name \
  -p image-url=$image_url \
  -p image-tag=$image_tag \
  -p git-url=$git_url
