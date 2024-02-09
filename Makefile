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
	oc create secret generic -n openshift-operators --from-file config.yaml=./apps/quay/config.yaml quay-init-config-bundle
	oc apply -f operators/openshift-quay-operator.yaml
	oc apply -f operators/openshift-quay-security-operator.yaml

.PHONY: bootstrap
bootstrap:
	oc apply -f apps/bootstrap/apps.yaml
	ansible-playbook -i ansible/inventory/ ansible/playbooks/quay.yml
	