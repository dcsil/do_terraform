# Digitalocean Terraform Tutorial

1. Clone this repo
1. [Install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
1. [Install doctl](https://docs.digitalocean.com/reference/doctl/how-to/install/)
1. Run `terraform init` in this repo
1. Run `doctl auth init` to login to DigitalOcean
1. Get an API token from your DigitalOcean account from https://cloud.digitalocean.com/account/api/tokens
1. Set it to `DIGITALOCEAN_TOKEN` in your terminal environment with `export DIGITALOCEAN_TOKEN=<your token>`
1. Run `terraform plan` to plan this terraform application
1. Run `terraform apply` to apply this to your DigitalOcean account
1. Run `./launch.sh` to launch nginx/load balancers on your Kubernetes Cluster
