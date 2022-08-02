# Tasks

## echo

This task runs a simple `echo` command with the given arguments.
It should typically be used for debugging purposes, or as a 'no-op' task.

### Parameters

### Results

### Workspaces


## image-digest

Extracts the image digest from a given container image using [skopeo](https://github.com/containers/skopeo).
### Parameters
| name         | type   | description                            |
| ------------ | ------ | -------------------------------------- |
| image        | string | Container image to find the digest of. |
| skopeo-image | string | Image ued to run skopeo.               |

### Results
| name   | description                   |
| ------ | ----------------------------- |
| digest | The digest of the given image |

### Workspaces


## kustomize-get-digest

Extracts an image digest from a `kustomization.yaml` file.
Typically used to "promote" an image between environment overlays.

### Parameters
| name       | type   | description                                                                                                                       |
| ---------- | ------ | --------------------------------------------------------------------------------------------------------------------------------- |
| image-name | string | URL of the container image to get the digest for.
Should match the value in `images[].name`.
Should not contain a digest or tag.
 |
| path       | string | Path to the kustomization file.                                                                                                   |
| filename   | string | Filename of the kustomization file.                                                                                               |
| yq-image   | string | Image to use for the `yq` step.
Must contain the `yq` binary in `PATH`.
                                                          |

### Results
| name   |
| ------ |
| digest |

### Workspaces
| name  |
| ----- |
| input |


## kustomize-set-image

Runs kustomize edit set image and commits the result.

### Parameters
| name            | type   | description                                                                      |
| --------------- | ------ | -------------------------------------------------------------------------------- |
| image-url       | string | The complete image URL to update, including digest or tag.                       |
| path            | string | The path of the kustomize overlay to update, relative to the `source` workspace. |
| git-branch      | string | Git branch to push changes to.                                                   |
| git-username    | string | Username of the git committer                                                    |
| git-email       | string | Email of the git committer                                                       |
| git-message     | string | First line of the commit message.                                                |
| kustomize-image | string |                                                                                  |
| git-image       | string |                                                                                  |

### Results
| name   | description                                     |
| ------ | ----------------------------------------------- |
| commit | The precise commit SHA after the git operation. |

### Workspaces
| name   | description                                           |
| ------ | ----------------------------------------------------- |
| source | A workspace that contains the fetched git repository. |


## kustomize

null
### Parameters

### Results

### Workspaces
| name   |
| ------ |
| source |


## next-env

Given a sequential list of environment strings, and the current environment, outputs
the next environment in the sequence.

Output will be blank if there is no next environment (i.e. the current environment is
production), or the given environment was invalid.

### Parameters
| name         | type   | description                                         |
| ------------ | ------ | --------------------------------------------------- |
| environment  | string | The current environment.                            |
| environments | array  | The sequential list of environments to select from. |
| image        | string | The image to use to run the script step.            |

### Results
| name   | description                                          |
| ------ | ---------------------------------------------------- |
| output | Holds the value of the next deployment environment.
 |

### Workspaces


## npm

null
### Parameters

### Results

### Workspaces
| name   |
| ------ |
| source |


## script-1001

null
### Parameters
| name       | type   |
| ---------- | ------ |
| script     | string |
| image      | string |
| workingDir | string |

### Results

### Workspaces
| name      | optional |
| --------- | -------- |
| workspace | true     |


## script-185

null
### Parameters
| name       | type   |
| ---------- | ------ |
| script     | string |
| image      | string |
| workingDir | string |

### Results

### Workspaces
| name      | optional |
| --------- | -------- |
| workspace | true     |


## script

null
### Parameters
| name   | type   | description                        |
| ------ | ------ | ---------------------------------- |
| script | string | Script to run.                     |
| image  | string | Image to run the script step with. |

### Results
| name   | description                     |
| ------ | ------------------------------- |
| output | Output any script results here. |

### Workspaces


## truncate-string

Truncates a string from the `start` to `end` character and outputs the result.

### Parameters
| name       | type   | description                          |
| ---------- | ------ | ------------------------------------ |
| input      | string | The string to be truncated.          |
| start      | string | The character to being the cut from. |
| end        | string | The character to end the cut from.   |
| step-image | string |                                      |

### Results
| name   | description           |
| ------ | --------------------- |
| output | The truncated string. |

### Workspaces


