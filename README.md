# Software Factory Templates

Install and configure the Software Factory Infrastructure

## TL;DR

### Install the operators

Subscribe to the operators:

```shell
make install-operators
```

Verify that the default GitOps instance is up-and-running:

```shell
oc get pods -n openshift-gitops
```

### Install the apps














### Install the Gitops/Pipeline operators

Get the Red Hat GitOps routes:

```shell
oc get route openshift-gitops-server -n openshift-gitops
```

Extract the Red Hat GitOps admin password:

```shell
oc extract secret/openshift-gitops-cluster -n openshift-gitops --to=-
```


### Create the Quay admin user

To create a default `admin` user, make a call to Quay's management API:

```shell
# get the quay api endpoint
oc get route quay-quay -n quay
```

```shell
# export the route URL
export QUAY=quay-registry-.... 
```

```shell
# create the user
curl -X POST -k  "https://$QUAY/api/v1/user/initialize" \
    --header 'Content-Type: application/json' \
    --data '{ "username": "admin", "password":"admin321", "email": "admin@example.com", "access_token": true}'
```

**Important:** save the access token somewhere, it is never shown again !
