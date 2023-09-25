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


### FIXING TERRAFORM CLI INSTALLATION FREEZE IN .GITPOD.YML
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




[^1]:https://www.washington.edu/doit/technology-tips-chmod-overview
[^2]:https://riptutorial.com/git/example/911/exceptions-in-a--gitignore-file