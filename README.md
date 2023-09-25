# Terraform Beginner Bootcamp 2023

# PREREQUISTES
- Debian/ubuntu machine
- AWS account
- 


## HOW TO DETERMINE YOUR LINUX KERNEL
Before installation of any linux binary, it is essential to determine the linux kernel that your machine is running on.

To check the linux kernel use the command below:

```sh
uname -m
x86_64
```

If the output of the command should return **X86_64** then your machine is running a 64-bit system, if the output is **aarch64** then your machine is running on ARM system


To see detailed infomation about the OS and the distribution information, run:

```sh
cat /etc/*elease
```

There should be a similar output like this:

```sh
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.3 LTS"
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

[Click here](https://www.herongyang.com/Linux/Linux-uname-Display-System-Information.html) for further review.

Now! We determined the Linux kernel and OS information.


## FIXING TERRAFORM CLI INSTALLATION FREEZE IN .GITPOD.YML
The issue in the CLI is the missing "y" flag in the code below:

```sh
sudo apt-add-repository "deb [arch=amd64] https://apt.releases hashicorp.com $(lsb_release -cs) main"
```

Created a bin folder to put in the binary for the installation on a linux for both AWS cli and Terraform, also create a file respectively for both. In the binary installation fines, **bash interpreter** will be used it satisfies our use case. 

For [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html), choose the binary for your system kernel and also for [TERRAFORM](https://developer.hashicorp.com/terraform/downloads) choose linux as your OS and paste the binaries respectively in the file created.

To run the binary installation files, the files should be executable by the user and the best security practices is to give the least priveledge that serves it purpose [^1]. Give the user executable permission then run the command with **./path-to-file** to confirm if there is no errors.

```
chmod u+x path-to-file
./path-to-file
```

update the .gitignore file to ignore aws files, made an exception for /bin/aws [^2]

```
aws*
```

## SETTING UP AWS CLI

Authenticating IAM users through the CLI[^3]. Login to your AWS account, create an IAM user[^3], fetch your access keys[^3], configure the aws cli[^3]. To configure the AWS cli, paste the respective values of the prompt:

```bash
aws configure
----
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json
---
```

To confirm if your credentials were succesfully injected, upon returning this is a success:
```
aws sts get-caller-identity
---
  "UserId": "434215245806",
  "Account": "434215245806",
  "Arn": "arn:aws:iam::434215245806:terraform-bootcamp"
---
```

Set up the env vars on gitpod using command **"export"** and **"gp env"**[^4] to inject the variables.

```
export "AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE"
gp env "AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE"

export AWS_SECRET_ACCESS_KEY= wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
gp env AWS_SECRET_ACCESS_KEY= wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

export AWS_DEFAULT_REGION=us-east-1
gp env AWS_DEFAULT_REGION=us-east-1

```
Get the list of environment variables with `env` and get a specific env vars with `env | grep <name>`

Stop the currentspace to spin a new workspace confirm if your credentials are injected.

## GENERATING A RANDOM BUCKET NAME WITH TERRAFORM
The [terraform registry](https://registry.terraform.io) is a public repository of Terraform modules and providers. Terraform uses to manage infrastructure resources. Run `terraform` to see the basic terraform commands.

### TERRAFORM MODULE
A Terraform module is a self-contained package of Terraform configurations that can be called and configured by other configurations. To use a Terraform module, you simply add it to your configuration using the module block.

```tf
module "vpc" {
  source = "hashicorp/aws/vpc/aws"
  version = "~> 3.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"
}
```

### TERRAFORM PROVIDER
Providers are available for a wide range of cloud providers, on-premises infrastructure, and other services.
You can install providers using the terraform init command.

### TERRAFORM INIT
Running terraform init downloads terraform binaries, lockfile and statefile.
NOTE: The **.terraform.lock.hcl** should be pushed to versioning control, the **terraform.tfstate** should not be pushed

### TERRAFORM RESOURCE
Resources are defined in Terraform configuration files using the resource block. The resource block specifies the type of resource, the provider that Terraform should use to manage the resource, and the properties of the resource.


### TERRAFORM RANDOM PROVIDER
The "random" provider allows the use of randomness within Terraform configurations. This is a logical provider, which means that it works entirely within Terraform's logic, and doesn't interact with any other services.

### GENERATE A RANDOM TERRAFORM BUCKET NAME
The provider to be used is the [random provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs) and the resource to be used is random_string.





[^1]:https://www.washington.edu/doit/technology-tips-chmod-overview
[^2]:https://riptutorial.com/git/example/911/exceptions-in-a--gitignore-file
[^3]:https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html
[^4]:https://www.gitpod.io/blog/securely-manage-development-secrets-with-doppler-and-gitpod