#!/usr/bin/env bash

set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$(realpath "$SCRIPT_DIR/../")


#ROUTE=$(oc get routes webhooks -o template='{{.spec.host}}')
ROUTE='webhooks.examples-cicd.apps.paas.lab.stocky37.dev'
TEMPLATE_FILE="$SCRIPT_DIR/templates/quay.json"

export NAME=greeting-ui
export NAMESPACE=tstockwell
export TAG=dev

body=$(cat "$TEMPLATE_FILE" | envsubst)

curl POST

curl -X POST \
  -H "Content-Type: application/json" \
  -d "$body" \
  "http://${ROUTE}"
