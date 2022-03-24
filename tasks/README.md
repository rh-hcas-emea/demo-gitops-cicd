# Tasks

## image-digest

Extracts the image digest from a given container image.

### Parameters

| Parameters   | Default                                  | Description                                                         |
|--------------|------------------------------------------|---------------------------------------------------------------------|
| **image**    |                                          | The image to find the digest of.                                    |
| skopeo-image | `registry.access.redhat.com/ubi8/skopeo` | The skopeo image to use.  Must contain the skopeo binary in `PATH`. |

### Results
| Name   | Description                    | 
|--------|--------------------------------|
| digest | The digest of the given image. |

## kustomize

Runs kustomize with the arguments provided.

### Parameters

| Parameters | Default                                 | Description                                                              |
|------------|-----------------------------------------|--------------------------------------------------------------------------|
| **args**   | `["version"]`                           | An array of the arguments to provide to the kustomize binary.            |
| path       | `k8s.gcr.io/kustomize/kustomize:v4.5.2` | The kustomize image to use. Must contain the kustomize binary in `PATH`. |

### Workspaces

| Name   | Description                                         |
|--------|-----------------------------------------------------|
| source | Should contain the source code to run kustomize on. |

## npm

Runs npm with the arguments provided. By default, uses NodeJS v16.

### Parameters

| Parameters | Default                                     | Description                                                     |
|------------|---------------------------------------------|-----------------------------------------------------------------|
| **args**   | `["--version"]`                             | An array of the arguments to provide to the npm binary.         |
| path       | `registry.access.redhat.com/ubi8/nodejs-16` | The NodeJS image to use. Must contain the npm binary in `PATH`. |

### Workspaces

| Name   | Description                                         |
|--------|-----------------------------------------------------|
| source | Should contain the source code to run kustomize on. |

## quay-webhook

Posts a mock [Quay: Repository Push](https://docs.quay.io/guides/notifications.html#repository-push) webhook to the given URL.

### Parameters

| Parameters          | Default                                   | Description                                                                         |
|---------------------|-------------------------------------------|-------------------------------------------------------------------------------------|
| **url**             | `http://el-greeting-cd-listener:8080`[^1] | URL to post the webhook to.                                                         |
| **image-name**      |                                           | Name of the container image (i.e. quay.io/<image-namespace>/**<image-name>**).      |
| **image-namespace** |                                           | Namespace of the container image (i.e. quay.io/**<image-namespace>**/<image-name>). |
| image-tag           | `latest`                                  | Tag of the container image                                                          |
| script-image        | `registry.access.redhat.com/ubi8-minimal` | The NodeJS image to use. Must contain the npm binary in `PATH`.                     |

[^1]: The default value should be removed when made more generic.

## script-x

The script task allows a pipeline to run a generic shell script.

There are two separate script-*x* tasks that differ only in the uid that they run with.
This is solely used as a workaround for an issue in the pipelines where the git clone tasks fail to clean the workspace due to permission errors.

There are likely better workarounds but this is the solution that I've ended up with for now.


### Parameters

| Parameters | Default                                   | Description                         |
|------------|-------------------------------------------|-------------------------------------|
| **script** |                                           | The script to run for this task.    |
| **image**  | `registry.access.redhat.com/ubi8-minimal` | The image to use to run the script. |

