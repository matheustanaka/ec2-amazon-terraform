# /bin/bash

echo "Starting environments"

terraform workspace select development
terraform plan
terraform apply --auto-approve

sleep 3;

terraform workspace select testing
terraform plan
terraform apply --auto-approve

sleep 3;

terraform workspace select production
terraform plan
terraform apply --auto-approve
