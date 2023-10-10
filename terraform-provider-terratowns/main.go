// this is where the declaration of the code starts
package main

// short for format
import {
	"fmt"
	"github.com/hashicorp/terraform/helper/schema"
	"github.com/hashicop/terraform-plugin-sdk/v2/plugin"
}
func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: Provider
	})
	// prints to 
    fmt.Println("Hello, World!")
}

func Provider() *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider {
		ResourcesMap: map[string]*schema.Resource{},
		DataSourceMap: map[string]*schema.Resource{},
		Schema: map[string]*schema.Resource{
			"endpoint": {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for the external service"
			},
			"token": {

			}
		},
	}
	p.ConfigureContextFunc = providerConfigure(p)
	return  p
} 
