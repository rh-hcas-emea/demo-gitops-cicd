#!/usr/bin/env bash

set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#ROUTE=$(oc get routes webhooks -o template='{{.spec.host}}')
ROUTE='webhooks.demo-gitops-cicd-cicd.apps.paas.lab.stocky37.dev'
TEMPLATE_FILE="$SCRIPT_DIR/templates/quay.json"

export NAME=greeting-ui
export NAMESPACE=tstockwell
export TAG="${1:-dev}"; shift

body=$(envsubst < "$TEMPLATE_FILE")

curl -X POST \
  -H "Content-Type: application/json" \
  -d "$body" \
  "http://${ROUTE}"
