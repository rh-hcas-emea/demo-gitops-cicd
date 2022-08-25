# GitOps CI/CD Demo

This repository contains the GitOps configuration and CI/CD implementation for the GitOps CI/CD demonstration.

It will deploy the Greeting Application using OpenShift Pipelines (Tekton) & OpenShift GitOps (ArgoCD). The Greeting Application consists of the following components:

- [greeting-api](https://github.com/tom-stockwell/greeting-api).
- [greeting-ui](https://github.com/tom-stockwell/greeting-ui)

[Kustomize](https://kustomize.io) is used to configure the Kubernetes resources for the applications. The configuration can be found in the following repositories:

- [greeting-api-k8s](https://github.com/tom-stockwell/greeting-api-k8s).
- [greeting-ui-k8s](https://github.com/tom-stockwell/greeting-ui-k8s)


## Prerequisites

- Access to an OpenShift cluster
- `oc` CLI client
- OpenShift Pipelines (Tekton) installed on the cluster
- OpenShift GitOps (ArgoCD) installed on the cluster
- The following namespaces:
    - `demo-gitops-cicd-cicd` 
    - `demo-gitops-cicd-gitops` 
    - `demo-gitops-cicd-dev` 
    - `demo-gitops-cicd-stage` 
    - `demo-gitops-cicd-prod`
- At least `edit` permissions on the `demo-gitops-cicd-gitops` namespace
- An instance of ArgoCD with access to manage the above namespaces deployed to `demo-gitops-cicd-gitops`

> **Note:** See [tom-stockwell/ocp-tenants//tenants/demo-gitops-cicd](https://github.com/tom-stockwell/ocp-tenants/tree/main/tenants/demo-gitops-cicd) for an example of the namespace configuration.

## Installation

Once the ArgoCD applications have been created, ArgoCD will manage both the applications and CI/CD configuration.
Run the following command to bootstrap the ArgoCD applications.

```shell
cluster=homelab
oc apply -k clusters/$cluster/gitops
```

If using an older version of `kubectl` or `oc` that does not support kustomize, you can achieve the same effect with the following:

```shell
kustomize build . | oc apply -f -
```
