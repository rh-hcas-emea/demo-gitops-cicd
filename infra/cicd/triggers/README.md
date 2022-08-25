# Tekton Triggers

The event listener can be triggered through the following URL: `webhooks.examples-cicd.apps.paas.lab.stocky37.dev`.

## Triggers

### argo-postsync

Handles PostSync hooks from ArgoCD, as created by [tom-stockwell/gitops-common//argocd-hook](https://github.com/tom-stockwell/gitops-common/tree/main/argocd-hook).
Triggers the [argo-postsync](../pipelines#argo-postsync) pipeline. 

Ensures the following:

- The `X-ArgoCD-Hook` header is set to `PostSync`
- The request body adheres to the following format:
    ```json
    {
      "name": "app-name",
      "environment": "env"
    }
    ```
- The environment is one of either `dev`, `stage`, or `prod`


### github-push-quarkus

Handles GitHub _push_  webhooks and triggers the [ci-quarkus](../pipelines#ci-quarkus) pipeline.

It is presently restricted to the `greeting-api` repository.

### github-push-react

Handles GitHub _push_ webhooks and triggers the [ci-react](../pipelines#ci-react) pipeline.

It is presently restricted to the `greeting-ui` repository.
