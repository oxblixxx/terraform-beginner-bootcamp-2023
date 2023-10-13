# Terraform Beginner Bootcamp 2023
![Diagram-](https://user-images.githubusercontent.com/7776/268042721-ab015431-2d14-4910-aa37-be4807b2b905.png)


## Weekly Journals
- [Week 0](https://github.com/oxblixxx/terraform-beginner-bootcamp-2023/blob/18-create-table-of-content-readmemd/journal/week%200.md)
- [Week 1](https://github.com/oxblixxx/terraform-beginner-bootcamp-2023/blob/18-create-table-of-content-readmemd/journal/week%201.md)


## EXTRAS
- [Markdown TOC Generator](https://derlin.github.io/bitdowntoc/)


### RUNNING TERRAFORM PROVIDER TERRATOWNS
cd into /workspaces/terraform-beginner-bootcamp-2023/terratowns_mock_server
run, this spins up `sinatra` hosted one port 4567

```
bundle install
bundle exec ruby server.rb
```

cd into /workspaces/terraform-beginner-bootcamp-2023//bin, run

```
./build-provider
```

this compiles the terraform provider for terratowns

then cd into /workspaces/terraform-beginner-bootcamp-2023, run:

```
terraform init
terraform apply
```

to create resources.