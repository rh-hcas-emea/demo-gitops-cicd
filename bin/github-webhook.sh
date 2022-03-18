#!/usr/bin/env bash

set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#ROUTE=$(oc get routes webhooks -o template='{{.spec.host}}')
ROUTE='webhooks.examples-cicd.apps.paas.lab.stocky37.dev'
TEMPLATE_FILE="$SCRIPT_DIR/templates/github.json"

#export NAME=greeting-ui
export NAME=greeting-api
export BRANCH=main
#export COMMIT=3af181b11e626881607a058861df6a675ba6f597
export COMMIT=873c59793302c8773af49aaf1adfb3146aceceea
export COMMIT_MSG="Mock commit message"

secret="${1:-secret}"; shift

body=$(envsubst < "$TEMPLATE_FILE")
sig=$(echo -n "$body" | openssl sha1 -binary -hmac "$secret" | xxd -p)
event="push"

curl -X POST \
  -H "X-Hub-Signature: sha1=$sig" \
  -H "X-GitHub-Event: $event" \
  -H "Content-Type: application/json" \
  -d "$body" \
  "http://${ROUTE}"
