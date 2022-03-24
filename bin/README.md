# Scripts

## `github-webhook.sh`

Imitates a GitHub *push* webhook to the event listener.
See `templates/quay.json` for the webhook content.

The script can be run with a `ui` (the default) or `api` argument in order to substitute variables for the different repositories, i.e.

```shell
$ ./bin/github-webhook.sh [api | ui]
```

The following variables will be substituted for each argument:

| JSON Path       | UI Value                                       | API Value                                       |
|-----------------|------------------------------------------------|-------------------------------------------------|
| repository.name | `greeting-ui`                                  | `greeting-api`                                  |
| repository.url  | `https://github.com/tom-stockwell/greeting-ui` | `https://github.com/tom-stockwell/greeting-api` |
| head_commit.id  | `3af181b11e626881607a058861df6a675ba6f597`     | `873c59793302c8773af49aaf1adfb3146aceceea`      |

See `templates/github.json` for the full webhook structure.

**Note:** The commit hash values will need to be kept up to date with the head commit of the `greeting-ui` and `greeting-api` repositories in order for the script to work as intended.

## `quay-webhook.sh`

Imitates a Quay *push* webhook to the event listener.
See `templates/quay.json` for the webhook content.

## `trigger-deploy.sh`

Manually triggers the `deploy` pipeline with the following variables:

| Name      | Value                                              |
|-----------|----------------------------------------------------|
| app-name  | `greeting-ui`                                      |
| image-url | `quay.io/tstockwell/greeting-ui`                   |
| image-tag | `latest`                                           |
| git-url   | `git@github.com:tom-stockwell/greeting-ui-k8s.git` |

