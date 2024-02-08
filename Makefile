VERSION = 1.0.0
NAMESPACE = sw-factory

.PHONY: namespace
namespace:
	oc new-project ${NAMESPACE}

.PHONY: install-operators
install-operators: install-gitops-operators install-quay-operator

.PHONY: install-gitops-operators
install-gitops-operators:
	oc apply -f operators/openshift-pipeline-operator.yaml
	oc apply -f operators/openshift-gitops-operator.yaml

.PHONY: install-quay-operator
install-quay-operator:
	oc create secret generic -n openshift-operators --from-file config.yaml=./operators/quay/config.yaml quay-init-config-bundle
	oc apply -f operators/openshift-quay-operator.yaml
	oc apply -f operators/openshift-quay-security-operator.yaml


.PHONY: bootstrap
bootstrap:
	oc apply -f apps/sw-factory/

.PHONY: cleanup
cleanup:
	oc delete application campaign-manager-backend-dev -n openshift-gitops --ignore-not-found=true
