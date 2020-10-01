TERRAFORM_VERSION := 0.12.24
-include .Makefile.terraform

.Makefile.terraform:
	curl -sSL https://raw.githubusercontent.com/tmknom/template-terraform-module/0.2.7/Makefile.terraform -o .Makefile.terraform

COMPLETE_DIR := ./

plan ## Run terraform plan
	$(call terraform,${COMPLETE_DIR},init,)
	$(call terraform,${COMPLETE_DIR},plan,)

apply: ## Run terraform apply
	$(call terraform,${COMPLETE_DIR},apply,)

destroy: ## Run terraform destroy
	$(call terraform,${COMPLETE_DIR},destroy,)
