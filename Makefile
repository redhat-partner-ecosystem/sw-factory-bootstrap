VERSION = 1.0.0
NAME = sw-factory

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
	oc apply -f apps/bootstrap/
	ansible-playbook -i inventory/ playbooks/bootstrap.yml
	
.PHONY: cleanup
cleanup:
	oc delete application vault -n openshift-gitops --ignore-not-found=true
	oc delete application sw-factory -n openshift-gitops --ignore-not-found=true
	oc delete project vault
	oc delete project quay
	oc delete project sw-factory
