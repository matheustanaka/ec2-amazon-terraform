# Public EC2 with Load Balancer

Provisioning Amazon Ec2 with Load Balancer. This project deploy multiple EC2 instances with public subnet and Load balancer.

<img src="./assets/AWS - Diagram.jpeg">

# Clone Project

```sh
# Clone with ssh
git clone git@github.com:matheustanaka/ec2-amazon-terraform.git

cd ec2-amazon-terraform
```

# Running terraform

```sh
# Initialize modules
terraform init

# Planning changes
terraform plan

# Applying changes
terraform apply
```

You can also create multiple evironments with terraform workspace. Ex:

```sh
# It creates a workspace for dev environment
terraform workspace new dev
```

Then, you can run the commands to initialize modules, plan and apply again.

# Support

If you find any issue, please open a pull request or feel free to reach me out on [X](https://x.com/matheus__tanaka)
