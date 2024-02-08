# Software Factory Templates

Install and configure the Software Factory Infrastructure

## TL;DR

### Install the Gitops/Pipeline operators

Get the Red Hat GitOps routes:

```shell
oc get route openshift-gitops-server -n openshift-gitops
```

Extract the Red Hat GitOps admin password:

```shell
oc extract secret/openshift-gitops-cluster -n openshift-gitops --to=-
```


