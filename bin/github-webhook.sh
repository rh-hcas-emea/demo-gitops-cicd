#!/usr/bin/env bash

set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#ROUTE=$(oc get routes webhooks -o template='{{.spec.host}}')
ROUTE='webhooks.demo-gitops-cicd-cicd.apps.paas.lab.stocky37.dev'
TEMPLATE_FILE="$SCRIPT_DIR/templates/github.json"
WEBHOOK_SECRET=secret

UI_NAME=greeting-ui
UI_COMMIT=3af181b11e626881607a058861df6a675ba6f597

API_NAME=greeting-api
API_COMMIT=873c59793302c8773af49aaf1adfb3146aceceea

case "${1:-ui}" in
  ui)
    export NAME=$UI_NAME
    export COMMIT=$UI_COMMIT
    ;;

  api)
    export NAME=$API_NAME
    export COMMIT=$API_COMMIT
    ;;
esac

body=$(envsubst < "$TEMPLATE_FILE")
sig=$(echo -n "$body" | openssl sha1 -binary -hmac "$WEBHOOK_SECRET" | xxd -p)
event="push"

curl -X POST \
  -H "X-Hub-Signature: sha1=$sig" \
  -H "X-GitHub-Event: $event" \
  -H "Content-Type: application/json" \
  -d "$body" \
  "http://${ROUTE}"
