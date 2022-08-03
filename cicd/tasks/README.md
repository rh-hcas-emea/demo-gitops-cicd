# Tasks

## array-find

This task finds the given item in an array and outputs various information related to it.
This can be used, for example, to select the next environment to deploy to given the current environment.

All results will be blank if they would result in an "IndexOutOfBounds"" exception.

### Parameters

| Name  | Type   | Default                                   | Description                         |
| ----- | ------ | ----------------------------------------- | ----------------------------------- |
| item  | string |                                           | The current item in the sequence.   |
| items | array  | `[]`                                      | The array of items to select from.  |
| image | string | `registry.access.redhat.com/ubi8-minimal` | The image to use to run the script. |

### Results

| Name  | Description                                  |
| ----- | -------------------------------------------- |
| index | The index value of the item.                 |
| prev  | The value of the previous item in the array. |
| next  | The value of the next item in the array.     |


## echo

This task can be used to run an `echo` command.

It can be used for debugging purposes, or as a 'no-op' task.

### Parameters

| Name  | Type   | Default                                   | Description                               |
| ----- | ------ | ----------------------------------------- | ----------------------------------------- |
| args  | array  | `[]`                                      | The arguments to pass to echo.            |
| image | string | `registry.access.redhat.com/ubi8-minimal` | The image used to run the `echo` command. |


## image-digest

This task can be used to find the image digest of a given container image.
It uses [skopeo](https://github.com/containers/skopeo) to inspect and output the image digest.

### Parameters

| Name         | Type   | Default                                  | Description                      |
| ------------ | ------ | ---------------------------------------- | -------------------------------- |
| image        | string |                                          | The image to find the digest of. |
| skopeo-image | string | `registry.access.redhat.com/ubi8/skopeo` | The image used to run skopeo.    |

### Results

| Name   | Description              |
| ------ | ------------------------ |
| digest | The digest of the image. |


## kustomize-get-digest

This task can be used to find the digest of a given image from a kustomization file.
This could then be used to promote an image between environment overlays.

**Note:** Since the digest is merely extracted from the YAML using [yq](https://mikefarah.gitbook.io/yq/), the digest will need to be present in the kustomization file for this to be successful.
E.g.
```
images:
  - name: registry.access.redhat.com/ubi8
    digest: sha256:6edca3916b34d10481e4d24d14ebe6ebc6db517bec1b2db6ae2d7d47c2ecfaee
```

### Parameters

| Name       | Type   | Default                         | Description                                                                                                 |
| ---------- | ------ | ------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| image-name | string |                                 | The name of the image to find the digest for. It should match the value in `images[].name`.                 |
| path       | string | `.`                             | The directory within which the kustomization file is located. Should be relative to the `source` workspace. |
| filename   | string | `kustomization.yml`             | The filename of the kustomization file.                                                                     |
| yq-image   | string | `docker.io/mikefarah/yq:4.25.2` | The image used to run yq.                                                                                   |

### Results

| Name   | Description              |
| ------ | ------------------------ |
| digest | The digest of the image. |

### Workspaces

| Name   | Optional | Read-Only | Description                               |
| ------ | -------- | --------- | ----------------------------------------- |
| source | false    | false     | A workspace that contains kustomizations. |


## kustomize-set-image

This task can be used to run `kustomize set image` and commit the result.
This can be used to promote images between overlays.

### Parameters

| Name            | Type   | Default                                             | Description                                                                                     |
| --------------- | ------ | --------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| image-url       | string |                                                     | The URL of the container image to set. Should include any relevant digests or tags.             |
| path            | string | `.`                                                 | The directory within which kustomize will be run. Should be relative to the `source` workspace. |
| git-branch      | string | `main`                                              | The git branch to push changes to.                                                              |
| git-username    | string | `ci`                                                | The username of the git committer.                                                              |
| git-email       | string | `101870882+stocky37-robot@users.noreply.github.com` | The email of the git committer.                                                                 |
| git-message     | string | `Update image`                                      | The first line of the commit message.                                                           |
| kustomize-image | string | `k8s.gcr.io/kustomize/kustomize:v4.5.5`             | The image used to run kustomize.                                                                |
| git-image       | string | `docker.io/alpine/git:v2.26.2`                      | The image used to run git.                                                                      |

### Results

| Name   | Description                                     |
| ------ | ----------------------------------------------- |
| commit | The precise commit SHA after the git operation. |

### Workspaces

| Name   | Optional | Read-Only | Description                                                              |
| ------ | -------- | --------- | ------------------------------------------------------------------------ |
| source | false    | false     | A workspace that contains a git repository that contains kustomizations. |


## kustomize

This task can be used to run [kustomize](https://kustomize.io/).

### Parameters

| Name            | Type   | Default                                 | Description                                                                                     |
| --------------- | ------ | --------------------------------------- | ----------------------------------------------------------------------------------------------- |
| args            | array  | `["version"]`                           | The arguments to pass to kustomize.                                                             |
| path            | string | `.`                                     | The directory within which kustomize will be run. Should be relative to the `source` workspace. |
| kustomize-image | string | `k8s.gcr.io/kustomize/kustomize:v4.5.5` | The image used to run kustomize.                                                                |

### Workspaces

| Name   | Optional | Read-Only | Description                               |
| ------ | -------- | --------- | ----------------------------------------- |
| source | false    | false     | A workspace that contains kustomizations. |


## script-1001

This task allows users to run an arbitrary script as uid 1001.
It is functionally identical to the [`script`](#script) task, aside from the security context used when running the script.

This is intended as a workaround for permissions issues when attempting to delete files in tasks that run using a different uid than the uid that created the files.

### Parameters

| Name       | Type   | Default                                   | Description                         |
| ---------- | ------ | ----------------------------------------- | ----------------------------------- |
| script     | string |                                           | The script to run.                  |
| image      | string | `registry.access.redhat.com/ubi8-minimal` | The image used to run the script.   |
| workingDir | string | `.`                                       | The directory to run the script in. |

### Results

| Name   | Description                |
| ------ | -------------------------- |
| output | Any results of the script. |

### Workspaces

| Name      | Optional | Read-Only | Description                                                                 |
| --------- | -------- | --------- | --------------------------------------------------------------------------- |
| workspace | true     | false     | An optional workspace that contains files that may be needed by the script. |


## script-185

This task allows users to run an arbitrary script as uid 185.
    It is functionally identical to the [`script`](#script) task, aside from the security context used when running the script.

This is intended as a workaround for permissions issues when attempting to delete files in tasks that run using a different uid than the uid that created the files.

### Parameters

| Name       | Type   | Default                                   | Description                         |
| ---------- | ------ | ----------------------------------------- | ----------------------------------- |
| script     | string |                                           | The script to run.                  |
| image      | string | `registry.access.redhat.com/ubi8-minimal` | The image used to run the script.   |
| workingDir | string | `.`                                       | The directory to run the script in. |

### Results

| Name   | Description                |
| ------ | -------------------------- |
| output | Any results of the script. |

### Workspaces

| Name      | Optional | Read-Only | Description                                                                 |
| --------- | -------- | --------- | --------------------------------------------------------------------------- |
| workspace | true     | false     | An optional workspace that contains files that may be needed by the script. |


## script

This task allows users to run an arbitrary script.

### Parameters

| Name       | Type   | Default                                   | Description                         |
| ---------- | ------ | ----------------------------------------- | ----------------------------------- |
| script     | string |                                           | The script to run.                  |
| image      | string | `registry.access.redhat.com/ubi8-minimal` | The image used to run the script.   |
| workingDir | string | `.`                                       | The directory to run the script in. |

### Results

| Name   | Description                |
| ------ | -------------------------- |
| output | Any results of the script. |

### Workspaces

| Name      | Optional | Read-Only | Description                                                                 |
| --------- | -------- | --------- | --------------------------------------------------------------------------- |
| workspace | true     | false     | An optional workspace that contains files that may be needed by the script. |


## truncate-string

This task truncates a given string from the `start` to `end` (inclusive) characters.
This could be used, for example, to obtain a truncated sha from a given image digest.

**An example:**
Calling the task with the following parameters:
```
- name: input
  value: sha256:6edca3916b34d10481e4d24d14ebe6ebc6db517bec1b2db6ae2d7d47c2ecfaee
- name: start
  value: '8'
- name: end
  value: '19'
```
would result in the `output` of `6edca3916b34`.

### Parameters

| Name  | Type   | Default                                   | Description                          |
| ----- | ------ | ----------------------------------------- | ------------------------------------ |
| input | string |                                           | The string to be truncated.          |
| start | string | `1`                                       | The character to begin the cut from. |
| end   | string | `8`                                       | The character to end the cut on.     |
| image | string | `registry.access.redhat.com/ubi8-minimal` | The image used to run the script.    |

### Results

| Name   | Description           |
| ------ | --------------------- |
| output | The truncated string. |

