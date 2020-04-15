
deploy-prod:
	ansible-playbook -i hosts.yaml deploy.yaml --extra-vars "target=prod"

deploy-preprod:
	ansible-playbook -i hosts.yaml deploy.yaml --extra-vars "target=preprod"

deploy-all:
	ansible-playbook -i hosts.yaml deploy.yaml --extra-vars "target=all"

test-prod: 
	curl http://192.168.140.19/

test-preprod: 
	curl http://192.168.140.78/
