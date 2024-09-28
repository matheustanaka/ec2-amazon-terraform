# /bin/bash

echo "Stopping environments"

terraform workspace select development
terraform plan
terraform destroy --auto-approve

sleep 3;

terraform workspace select testing
terraform plan
terraform destroy --auto-approve

sleep 3;

terraform workspace select production
terraform plan
terraform destroy --auto-approve
