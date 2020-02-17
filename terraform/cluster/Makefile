extra_vars=-var-file="../inputs.tfvars" -var-file="./inputs.tfvars"
topology=.

fmt:
	terraform fmt -recursive -write=true

init:
	terraform init -upgrade=true -reconfigure $(topology)

plan:
	terraform plan $(extra_vars) $(topology)

apply:
	terraform apply $(extra_vars) -auto-approve $(topology)

destroy:
	terraform destroy $(extra_vars) -auto-approve $(topology)
