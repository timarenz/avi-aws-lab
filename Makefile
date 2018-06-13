export TF_VAR_access_key="AKIAJ3ZIQ4UTNCWWHYZA"
export TF_VAR_secret_key="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"
export TF_VAR_password="avidemo123"

apply:
	terraform apply -var environment=$(environment) -state=state/terraform-$(environment).tfstate -auto-approve
	terraform output -state=state/terraform-$(environment).tfstate -json > outputs/$(environment).out

init:
	terraform init

plan:
	terraform plan -var environment=$(environment) -state=state/terraform-$(environment).tfstate

destroy:
	terraform destroy -force -var environment=$(environment) -state=state/terraform-$(environment).tfstate