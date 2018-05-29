apply:
	terraform apply -var environment=$(environment) -state=state/terraform-$(environment).tfstate -auto-approve
	terraform output -state=state/terraform-$(environment).tfstate -json > outputs/$(environment).out

init:
	terraform init

plan:
	terraform plan -var environment=$(environment) -state=state/terraform-$(environment).tfstate

destroy:
	terraform destroy -force -var environment=$(environment) -state=state/terraform-$(environment).tfstate