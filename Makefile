
deploy-test-prod: deploy-prod test-prod

deploy-prod:
	ansible-playbook -i hosts.yaml deploy.yaml --extra-vars "target=prod"

deploy-test-preprod: deploy-prod test-preprod

deploy-preprod:
	ansible-playbook -i hosts.yaml deploy.yaml --extra-vars "target=preprod"

deploy-test-all: deploy-all test-prod test-preprod

deploy-all:
	ansible-playbook -i hosts.yaml deploy.yaml --extra-vars "target=all"

test-prod: 
	curl http://192.168.140.20/

test-preprod: 
	curl http://192.168.140.50/

show-tags:
	ansible-playbook -i hosts.yaml deploy.yaml --extra-vars "target=all" --list-tags