#!/usr/bin/env bash

set -x

SCRIPT_DIR=$( realpath "$( dirname "${BASH_SOURCE[0]}" )")

ROUTE=$(oc -n demo-cicd get route webhooks -o template='{{.spec.host}}')
TEMPLATE_FILE="$SCRIPT_DIR/templates/github.json"
WEBHOOK_SECRET=secret

UI_NAME=greeting-ui
UI_COMMIT=5366acdd375c9751348c35d5820f7e920bf2db9d

API_NAME=greeting-api
API_COMMIT=30dcc951ec76c952a9590463dfd0aad133aeb830

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
