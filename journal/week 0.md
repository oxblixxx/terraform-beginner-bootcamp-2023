<!-- TOC start (generated with https://github.com/derlin/bitdowntoc) -->

# Terraform Beginner Bootcamp 2023 - Week 0
   * [PREREQUISTES](#PREQUISTES)
   * [HOW TO DETERMINE YOUR LINUX KERNEL](#how-to-determine-your-linux-kernel)
   * [FIXING TERRAFORM CLI INSTALLATION FREEZE IN .GITPOD.YML](#fixing-terraform-cli-installation-freeze-in-gitpodyml)
   * [SETTING UP AWS CLI](#setting-up-aws-cli)
   * [GENERATING A RANDOM BUCKET NAME WITH TERRAFORM](#generating-a-random-bucket-name-with-terraform)
      + [TERRAFORM MODULE](#terraform-module)
      + [TERRAFORM PROVIDER](#terraform-provider)
      + [TERRAFORM INIT](#terraform-init)
      + [TERRAFORM RESOURCE](#terraform-resource)
      + [TERRAFORM RANDOM PROVIDER](#terraform-random-provider)
      + [GENERATE A RANDOM TERRAFORM BUCKET NAME](#generate-a-random-terraform-bucket-name)
   * [TERRAFORM CLOUD INTERGRATION](#terraform-cloud-intergration)
      + [DIFFICULTY WITH TERRAFORM LOGIN COMMAND](#difficulty-with-terraform-login-command)
      + [FIX TERRAFORM LOGIN MY RUNNING SCRIPT TO CREATE A TEMPLATE](#fix-terraform-login-my-running-script-to-create-a-template)
      + [SETTING TF ENV VARIABLES ON TERRAFORM CLOUD](#setting-tf-env-variables-on-terraform-cloud)
   * [ADD ALIAS FOR TF](#add-alias-for-tf)

<!-- TOC end -->

<!-- TOC --><a name="terraform-beginner-bootcamp-2023"></a>
# Terraform Beginner Bootcamp 2023

<!-- TOC --><a name="prerequistes"></a>
# PREREQUISTES
- Debian/ubuntu machine
- AWS account
- 


<!-- TOC --><a name="how-to-determine-your-linux-kernel"></a>
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


<!-- TOC --><a name="fixing-terraform-cli-installation-freeze-in-gitpodyml"></a>
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

<!-- TOC --><a name="setting-up-aws-cli"></a>
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

Set up the env vars on gitpod using command **"export"** and **"gp env"**[^4] to inject the variables in gitpod.



```
% export AWS_ACCESS_KEY_ID="anaccesskey"
% export AWS_SECRET_ACCESS_KEY="asecretkey"
% export AWS_REGION="us-west-2

export AWS_ACCESS_KEY_ID='AKIAIOSFODNN7EXAMPLE
gp env AWS_ACCESS_KEY_ID='AKIAIOSFODNN7EXAMPLE'

export AWS_SECRET_ACCESS_KEY='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
gp env AWS_SECRET_ACCESS_KEY='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'

export AWS_REGION='us-east-1'
gp env AWS_REGION='us-east-1'

```
Get the list of environment variables with `env` and get a specific env vars with `env | grep <name>`. Use the unset `<env_var>` to remove set variables. Use the `gp env` to see list of variables for gitpod and `gp env -u <env-var>` to unset.
 
Stop the currentspace to spin a new workspace confirm if your credentials are injected.

<!-- TOC --><a name="generating-a-random-bucket-name-with-terraform"></a>
## GENERATING A RANDOM BUCKET NAME WITH TERRAFORM
The [terraform registry](https://registry.terraform.io) is a public repository of Terraform modules and providers. Terraform uses to manage infrastructure resources. Run `terraform` to see the basic terraform commands.

<!-- TOC --><a name="terraform-module"></a>
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

<!-- TOC --><a name="terraform-provider"></a>
### TERRAFORM PROVIDER
Providers are available for a wide range of cloud providers, on-premises infrastructure, and other services.
You can install providers using the terraform init command.

<!-- TOC --><a name="terraform-init"></a>
### TERRAFORM INIT
Running terraform init downloads terraform binaries, lockfile and statefile.
NOTE: The **.terraform.lock.hcl** should be pushed to versioning control, the **terraform.tfstate** should not be pushed. `terraform apply --auto-approve` applies the change without prompting for yes. `terraform destroy --auto-approve` destroys the infrastructure, without prompt, instead use `terraform destroy`. `Terraform plan` shows the changeset of the infrastructure, if you get this error, check again with setting up your aws credentials with `aws configure`

```sh
 Error: No valid credential sources found
│ 
│   with provider["registry.terraform.io/hashicorp/aws"],
│   on <empty> line 0:
│   (source code not available)
│ 
│ Please see
│ https://registry.terraform.io/providers/hashicorp/aws
│ for more information about providing credentials.
│ 
│ Error: failed to refresh cached credentials, no EC2 IMDS role
│ found, operation error ec2imds: GetMetadata, request canceled,
│ context deadline exceeded
```

<!-- TOC --><a name="terraform-resource"></a>
### TERRAFORM RESOURCE
Resources are defined in Terraform configuration files using the resource block. The resource block specifies the type of resource, the provider that Terraform should use to manage the resource, and the properties of the resource.


<!-- TOC --><a name="terraform-random-provider"></a>
### TERRAFORM RANDOM PROVIDER
The "random" provider allows the use of randomness within Terraform configurations. This is a logical provider, which means that it works entirely within Terraform's logic, and doesn't interact with any other services.

<!-- TOC --><a name="generate-a-random-terraform-bucket-name"></a>
### GENERATE A RANDOM TERRAFORM BUCKET NAME
The provider to be used is the [random provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs) and the resource to be used is random_string.


<!-- TOC --><a name="terraform-cloud-intergration"></a>
## TERRAFORM CLOUD INTERGRATION
Create a [terraform account](https://app.terraform.io/). Generate aN API token, by going to user settings and locate token. Create a new project and workspace, A project in Terraform Cloud is a container for workspaces. Every workspace needs to be a child of a project. Existing workspaces are automatically deployed in the Default Project workspace[^5]. 

Update your .tf file to intergrate with Terraform cloud.

```sh
terraform {
  cloud {
    organization = "oxblixxx"

    workspaces {
      name = "aws-terraform"
    }
  }
}
```

<!-- TOC --><a name="difficulty-with-terraform-login-command"></a>
### DIFFICULTY WITH TERRAFORM LOGIN COMMAND

While running `terraform login` I couldnt't login to authenticate. Google bard advised to create a .json file in this directory `/home/gitpod/.terraform.d/credentials.tfrc.json`


```sh
{
  "credentials": {
    "hostname": {
      "token": "YOUR_AUTHENTICATION_TOKEN"
    }
  }
}
```

If you get this error while running `terraform init`

```sh
Usage: terraform [global options] login [hostname]

  Retrieves an authentication token for the given hostname, if it supports
  automatic login, and saves it in a credentials file in your home directory.

  If no hostname is provided, the default hostname is app.terraform.io, to
  log in to Terraform Cloud.

  If not overridden by credentials helper settings in the CLI configuration,
  the credentials will be written to the following local file:
      /home/gitpod/.terraform.d/credentials.tfrc.json
```

Change the `hostname` to `app.terraform.io`


```
{
  "credentials": {
    "app.terraform.io": {
      "token": "1234567890abcdef0"
    }
  }
}

```

Run `Terraform init` again and `terraform plan` to see the changeset then run `terraform apply --auto-approve`

<!-- TOC --><a name="fix-terraform-login-my-running-script-to-create-a-template"></a>
### FIX TERRAFORM LOGIN MY RUNNING SCRIPT TO CREATE A TEMPLATE
ChatGPT create a script to created a script to automate creating template for `credentials.tfrc.json`.

Created a folder template, then created a file with the above json credential block of code.

```sh
#!/bin/bash

# Get the path to the file that you want to put in the credentials folder

file_path=../template/credentials.trfc.json


# Create the credentials folder if it doesn't exist
if [ ! -d "/home/gitpod/.terraform.d/credentials" ]; then
  mkdir -p "/home/gitpod/.terraform.d/credentials"
fi

# Copy the file to the credentials folder
cp "$file_path" "/home/gitpod/.terraform.d/credentials/credentials.tfrc.json"

# Print a success message
echo "File copied successfully to /home/gitpod/.terraform.d/credentials/credentials.tfrc.json"
```

NB: Ensure not to put your token in the template, because you wouldnt want to expose that.

Update .gitpod.yml to run the script after opening up a new workspace by updating the terraform task block

```
      soruce /workspace/terraform-beginner-bootcamp-2023/bin/create_credentials_trfc
```

Manually put in your token in the folder

```
nano /home/gitpod/.terraform.d/credentials/credentials.tfrc.json
```


<!-- TOC --><a name="setting-tf-env-variables-on-terraform-cloud"></a>
### SETTING TF ENV VARIABLES ON TERRAFORM CLOUD
After hours of dealing with running `terraform plan` got this error:

```sh
╷
│ Error: validating provider credentials: retrieving caller identity from STS: operation error STS: GetCallerIdentity, failed to resolve service endpoint, endpoint rule error, Invalid Configuration: Missing Region
│ 
│   with provider["registry.terraform.io/hashicorp/aws"],
│   on main.tf line 27, in provider "aws":
│   27: provider "aws" {
```
[The solution](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-remote?wvideo=a2i7g8n5zj) to the error is to set up environment variables on the [Terraform cloud console](https://app.terraform.io). Open your workspace.

On the left sidebar is `variables` set up `AWS_REGION`, `AWS_SECRET_ACCESS_KEY`, `AWS_ACCESS_KEY_ID` as it is on your local machine. After setting your env vars, click on run to authenticate the credentials on `Terraform console`. Henceforth you can from your local machine CLI.

NB: IF you have your `ACCESS KEY` details in the provider block in your tf file, this won't be necessary. If only you are Authenticated via CLI.





<!-- TOC --><a name="add-alias-for-tf"></a>
## ADD ALIAS FOR TF
Google bard wrote a script to update `~/.bash_profile` with tf alias for terraform. Created a file in bin `tf_alias` and pasted the code there, tested it. Works smoothly. Update .gitpod.yml to automate the alias on spinning a new workspace.





[^1]:https://www.washington.edu/doit/technology-tips-chmod-overview
[^2]:https://riptutorial.com/git/example/911/exceptions-in-a--gitignore-file
[^3]:https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html
[^4]:https://www.gitpod.io/blog/securely-manage-development-secrets-with-doppler-and-gitpod
[^5]:https://nedinthecloud.com/2023/02/09/terraform-cloud-managing-your-workspaces-with-projects/#:~:text=A%20project%20in%20Terraform%20Cloud,workspaces%20between%20projects%20as%20needed.
