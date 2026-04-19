set dotenv-load := true
set dotenv-override := true

export AWS_PROFILE := "tech1savvy"

[default]
init-plan-apply:
     just init
     just plan
     just apply

init:
    terraform init

plan:
    terraform plan -out=.tfplan

apply:
    terraform apply .tfplan

destroy:
    terraform destroy

clean:
    rm -f tfplan
    rm -rf .terraform
    rm -f .terraform.lock.hcl

clean-state:
    rm -f terraform.tfstate terraform.tfstate.backup

state:
    terraform state list
