
# Terraform Beginner Bootcamp 2023 - Week 2

## WORKING WITH RUBY

### BUNDLER
In Ruby, Bundler is a tool that helps manage a project's dependencies. It simplifies the process of specifying and installing the gems (Ruby libraries) that your project relies on. Bundler uses a Gemfile to specify the dependencies for a Ruby project. Once you have a Gemfile, you can use the bundle install command to install the specified gems along with their dependencies. When running Ruby scripts or commands that depend on the gems specified in your Gemfile, it's a good practice to use bundle exec. For example, instead of running rails server, you would run bundle exec rails server. 

### INSTALL GEMS
To install gems in Ruby, you can use the gem command, which is Ruby's package manager. To install a specific gem

```
gem install gem_name
```

To install rails:

```
gem install rails
```

### EXECUCTING RUBY SCRIPTS IN THE CONTEXT OF BUNDLER
When running Ruby scripts in the context of Bundler, you want to make sure that your script uses the gems specified in your Gemfile. Here are the steps to run a Ruby script with Bundler:
Pass the script name to the ruby command:

bundle exec ruby [script_file_name]
### SINATRA

[Sinatra](https://sinatrarb.com/) is a lightweight and flexible web application framework written in Ruby. It is often referred to as a micro-framework because of its simplicity and minimalistic design. Despite its size, Sinatra is powerful and well-suited for building small to medium-sized web applications and APIs. Here are some key features and aspects of Sinatra:


### INSTALL GEMS


### EXECUCTING RUBY SCRIPTS IN THE CONTEXT OF BUNDLER

## TERRATOWNS MOCK SERVER

### RUNNING THE WEB SERVER
We can run the web server by executing the following commands:
```
bundle install
bundle exec ruby server.rb
```
All of the code for our server is stored in the `server.rb` file.

##TERRAFORM-PROVIDER-TERRATOWS

###SKELETON FOR CUSTOM PROVIDER
Create a dir $PROJECT_ROOT/terraform-provider-terratowns directory
```
mkdir terraform-provider-terratowns
```
Create a `main.go` file && a `go.mod` file in $PROJECT_ROOT/terraform-provider-terratowns directory. 
```
touch main.go && touch go.mod
```

In your `main.go` && `go.mod` file update it with the code below:

```go
///////main.go
// package main: Declares the package name. 
// The main package is special in Go, it's where the execution of the program starts.
package main

// fmt is short format, it contains functions for formatted I/O.
import (
	"bytes"
	"context"
	"encoding/json"
	"net/http"
	"log"
	"fmt"
	"github.com/google/uuid"
	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)
// func main(): Defines the main function, the entry point of the app. 
// When you run the program, it starts executing from this function.
func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: Provider,
	})
	// Format.PrintLine
	// Prints to standard output
	fmt.Println("Hello, world!")
}

type Config struct {
	Endpoint string
	Token string
	UserUuid string
}

// in golang, a titlecase function will get exported.
func Provider() *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap:  map[string]*schema.Resource{
			"terratowns_home": Resource(),
		},
		DataSourcesMap:  map[string]*schema.Resource{

		},
		Schema: map[string]*schema.Schema{
			"endpoint": {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for hte external service",
			},
			"token": {
				Type: schema.TypeString,
				Sensitive: true, // make the token as sensitive to hide it the logs
				Required: true,
				Description: "Bearer token for authorization",
			},
			"user_uuid": {
				Type: schema.TypeString,
				Required: true,
				Description: "UUID for configuration",
				ValidateFunc: validateUUID,
			},
		},
	}
	p.ConfigureContextFunc = providerConfigure(p)
	return p
}

func validateUUID(v interface{}, k string) (ws []string, errors []error) {
	log.Print("validateUUID:start")
	value := v.(string)
	if _, err := uuid.Parse(value); err != nil {
		errors = append(errors, fmt.Errorf("invalid UUID format"))
	}
	log.Print("validateUUID:end")
	return
}

func providerConfigure(p *schema.Provider) schema.ConfigureContextFunc {
	return func(ctx context.Context, d *schema.ResourceData) (interface{}, diag.Diagnostics ) {
		log.Print("providerConfigure:start")
		config := Config{
			Endpoint: d.Get("endpoint").(string),
			Token: d.Get("token").(string),
			UserUuid: d.Get("user_uuid").(string),
		}
		log.Print("providerConfigure:end")
		return &config, nil
	}
}

func Resource() *schema.Resource {
	log.Print("Resource:start")
	resource := &schema.Resource{
		CreateContext: resourceHouseCreate,
		ReadContext: resourceHouseRead,
		UpdateContext: resourceHouseUpdate,
		DeleteContext: resourceHouseDelete,
		Schema: map[string]*schema.Schema{
			"name": {
				Type: schema.TypeString,
				Required: true,
				Description: "Name of home",
			},
			"description": {
				Type: schema.TypeString,
				Required: true,
				Description: "Description of home",
			},
			"domain_name": {
				Type: schema.TypeString,
				Required: true,
				Description: "Domain name of home eg. *.cloudfront.net",
			},
			"town": {
				Type: schema.TypeString,
				Required: true,
				Description: "The town to which the home will belong to",
			},
			"content_version": {
				Type: schema.TypeInt,
				Required: true,
				Description: "The content version of the home",
			},
		},
	}
	log.Print("Resource:start")
	return resource
}

func resourceHouseCreate(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	log.Print("resourceHouseCreate:start")
	var diags diag.Diagnostics

	config := m.(*Config)

	payload := map[string]interface{}{
		"name": d.Get("name").(string),
		"description": d.Get("description").(string),
		"domain_name": d.Get("domain_name").(string),
		"town": d.Get("town").(string),
		"content_version": d.Get("content_version").(int),
	}
	payloadBytes, err := json.Marshal(payload)
	if err != nil {
		return diag.FromErr(err)
	}

	url :=  config.Endpoint+"/u/"+config.UserUuid+"/homes"
	log.Print("URL: "+ url)
	// Construct the HTTP Request
	req, err := http.NewRequest("POST", url, bytes.NewBuffer(payloadBytes))
	if err != nil {
		return diag.FromErr(err)
	}

	// Set Headers
	req.Header.Set("Authorization", "Bearer "+config.Token)
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Accept", "application/json")

	client := http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return diag.FromErr(err)
	}
	defer resp.Body.Close()

	// parse response JSON
	var responseData map[string]interface{}
	if err := json.NewDecoder(resp.Body).Decode(&responseData);  err != nil {
		return diag.FromErr(err)
	}

	// StatusOK = 200 HTTP Response Code
	if resp.StatusCode != http.StatusOK {
		return diag.FromErr(fmt.Errorf("failed to create home resource, status_code: %d, status: %s, body %s", resp.StatusCode, resp.Status, responseData))
	}

	// handle response status

	homeUUID := responseData["uuid"].(string)
	d.SetId(homeUUID)

	log.Print("resourceHouseCreate:end")

	return diags
}

func resourceHouseRead(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	log.Print("resourceHouseRead:start")
	var diags diag.Diagnostics

	config := m.(*Config)

	homeUUID := d.Id()

	// Construct the HTTP Request
	url := config.Endpoint+"/u/"+config.UserUuid+"/homes/"+homeUUID
	log.Print("URL: "+ url)
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return diag.FromErr(err)
	}

	// Set Headers
	req.Header.Set("Authorization", "Bearer "+config.Token)
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Accept", "application/json")

	client := http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return diag.FromErr(err)
	}
	defer resp.Body.Close()

	var responseData map[string]interface{}

	if resp.StatusCode == http.StatusOK {
		// parse response JSON
		if err := json.NewDecoder(resp.Body).Decode(&responseData);  err != nil {
			return diag.FromErr(err)
		}
		d.Set("name",responseData["name"].(string))
		d.Set("description",responseData["description"].(string))
		d.Set("domain_name",responseData["domain_name"].(string))
		d.Set("content_version",responseData["content_version"].(float64))
	} else if resp.StatusCode != http.StatusNotFound {
		d.SetId("")
	} else if resp.StatusCode != http.StatusOK {
		return diag.FromErr(fmt.Errorf("failed to read home resource, status_code: %d, status: %s, body %s", resp.StatusCode, resp.Status, responseData))
	}

	log.Print("resourceHouseRead:end")

	return diags
}

func resourceHouseUpdate(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	log.Print("resourceHouseUpdate:start")
	var diags diag.Diagnostics

	config := m.(*Config)

	homeUUID := d.Id()

	payload := map[string]interface{}{
		"name": d.Get("name").(string),
		"description": d.Get("description").(string),
		"content_version": d.Get("content_version").(int),
	}
	payloadBytes, err := json.Marshal(payload)
	if err != nil {
		return diag.FromErr(err)
	}

	// Construct the HTTP Request
	url := config.Endpoint+"/u/"+config.UserUuid+"/homes/"+homeUUID
	log.Print("URL: "+ url)
	req, err := http.NewRequest("PUT", url, bytes.NewBuffer(payloadBytes))
	if err != nil {
		return diag.FromErr(err)
	}

	// Set Headers
	req.Header.Set("Authorization", "Bearer "+config.Token)
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Accept", "application/json")

	client := http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return diag.FromErr(err)
	}
	defer resp.Body.Close()

	// StatusOK = 200 HTTP Response Code
	if resp.StatusCode != http.StatusOK {
		return diag.FromErr(fmt.Errorf("failed to update home resource, status_code: %d, status: %s", resp.StatusCode, resp.Status))
	}

	log.Print("resourceHouseUpdate:end")

	d.Set("name",payload["name"])
	d.Set("description",payload["description"])
	d.Set("content_version",payload["content_version"])
	return diags
}

func resourceHouseDelete(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	log.Print("resourceHouseDelete:start")
	var diags diag.Diagnostics

	config := m.(*Config)

	homeUUID := d.Id()

	// Construct the HTTP Request
	url :=  config.Endpoint+"/u/"+config.UserUuid+"/homes/"+homeUUID
	log.Print("URL: "+ url)
	req, err := http.NewRequest("DELETE", url , nil)
	if err != nil {
		return diag.FromErr(err)
	}

	// Set Headers
	req.Header.Set("Authorization", "Bearer "+config.Token)
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Accept", "application/json")

	client := http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return diag.FromErr(err)
	}
	defer resp.Body.Close()

	// StatusOK = 200 HTTP Response Code
	if resp.StatusCode != http.StatusOK {
		return diag.FromErr(fmt.Errorf("failed to delete home resource, status_code: %d, status: %s", resp.StatusCode, resp.Status))
	}

	d.SetId("")

	log.Print("resourceHouseDelete:end")
	return diags
}
```

For go.mod below:
```sh
module github.com/ExamProCO/terraform-provider-terratowns

go 1.20

replace github.com/ExamProCo/terraform-provider-terratowns => /workspaces/terraform-beginner-bootcamp-2023/terraform-provider-terratowns
```

On your terminal run:

```sh
go build -o terraform-provider-terratowns_v1.0.0
```

You should get this output on your terminal

```sh
main.go:13:2: no required module provides package github.com/google/uuid; to add it:
        go get github.com/google/uuid
main.go:14:2: no required module provides package github.com/hashicorp/terraform-plugin-sdk/v2/diag; to add it:
        go get github.com/hashicorp/terraform-plugin-sdk/v2/diag
main.go:15:2: no required module provides package github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema; to add it:
        go get github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema
main.go:16:2: no required module provides package github.com/hashicorp/terraform-plugin-sdk/v2/plugin; to add it:
        go get github.com/hashicorp/terraform-plugin-sdk/v2/plugin
```

To add the required module provides package, c & p the below on your terminal as prompted:

```sh
go get github.com/google/uuid
go get github.com/hashicorp/terraform-plugin-sdk/v2/diag
go get github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema
go get github.com/hashicorp/terraform-plugin-sdk/v2/plugin
```


Check your `go.mod` file, it should have the packages downloaded in a `require block` and there should be newly created files  `go.sum` and `terraform-provider-terratowns_v1.0.0`

Create a script in /bin folder to build the provider:

```sh
#! /usr/bin/bash

#! /usr/bin/bash

PLUGIN_DIR="/home/codespace/.terraform.d/plugins/local.providers/local/terratowns/1.0.0/"
PLUGIN_NAME="terraform-provider-terratowns_v1.0.0"

# https://servian.dev/terraform-local-providers-and-registry-mirror-configuration-b963117dfffa
cp "$PROJECT_ROOT/template/terraformrc" "/home/codespace/.terraformrc"
cd "$PROJECT_ROOT/terraform-provider-terratowns"
sudo rm -rf "/home/codespace/.terraform.d/plugins"
sudo rm -rf $PROJECT_ROOT/.terraform
sudo rm -rf $PROJECT_ROOT/.terraform.lock.hcl
go build -o "$PLUGIN_NAME"
sudo mkdir -p "$PLUGIN_DIR/x86_64/"
sudo mkdir -p "$PLUGIN_DIR/linux_amd64/"
sudo cp $PLUGIN_NAME "$PLUGIN_DIR/x86_64"
sudo cp "$PLUGIN_NAME" "$PLUGIN_DIR/linux_amd64"
```

NB: THE DIRECTORY TO YOUR FOLDER PATH WILL BE DEIFFERENT, I HAVE MY PROJECT SPINNED UP GITHUB CODESPACES

Make the binary file above executable:

```sh
chmod u+x build_provider
```

Run the script to see if there is any error:
```sh
./build_provider
```

Confirm if the files are copied to it's right  directory.

From our previous `.tf` files in $PROJECT_ROOT. Comment them out:
```tf
output.tf
variables.tf
main.tf
provider.tf
```

Define a provider for `terratowns` and set it's endpoint, user_uuid && token.

```sh
terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "terratowns" {
    endpoint = "http://localhost:4567"
    user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
    token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"

}
```

Run  `terraform init`, if all is done properly there should be no errors. Run `terraform apply` to create `.state` file.

To see detailed debugs, run:

```sh
TF_LOG=DEB terraform init
```

### CRUD
