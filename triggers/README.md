# Tekton Triggers

The event listener can be triggered through the following URL: `webhooks.examples-cicd.apps.paas.lab.stocky37.dev`.

## Triggers

### github-push-quarkus

Intercepts GitHub webhook _push_ events and passes them through to the [ci-quarkus](#ci-quarkus) trigger template, which in turn triggers the [ci-quarkus](../pipelines#ci-quarkus) pipeline.

It is presently restricted to the `greeting-api` repository.

### github-push-reacy

Intercepts GitHub webhook _push_ events and passes them through to the [ci-react](#ci-react) trigger template, which in turn triggers the [ci-react](../pipelines#ci-react) pipeline.

It is presently restricted to the `greeting-ui` repository.

### quay-push

Intercepts Quay webhooks and passes them through to the [deploy](#deploy) trigger template, which in turn triggers the [deploy](../pipelines#deploy) pipeline.


Since a built-in interceptor for Quay webhooks does not exist, this trigger ensures that the following fields are present in the webhook JSON body:

```json
{
	"name": "repository",
	"repository": "mynamespace>/<repository",
	"namespace": "mynamespac",
	"docker_url": "quay.io/mynamespace/repository",
	"updated_tags": [
		"latest"
	]
}
```

Additionally, the trigger is run only when the first value in `updated_tags` in one of either `dev`, `stage` or `prod`.
This ensures that only these environment tags trigger the deployment pipeline.

## Trigger Templates

TODO: should I bother listing the parameters for each of these?

### ci-quarkus

### ci-react

### deploy

## Trigger Bindings

### quay-repo-push

Binds the following fields of a Quay _push_ repository notification to the following trigger template parameters:

| Field        | Source | Parameter         |
|--------------|--------|-------------------|
| `name`       | body   | `name`            |
| `repository` | body   | `image`           |
| `docker_url` | body   | `image-url`       |
| `namespace`  | body   | `image-namespace` |
| `tags`       | body   | `updated_tags`    |
| `tag`        | body   | `updated_tags[0]` |

