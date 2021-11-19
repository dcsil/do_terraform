# Digitalocean Terraform Tutorial

1. Clone this repo
1. [Install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
1. [Install doctl](https://docs.digitalocean.com/reference/doctl/how-to/install/)
1. Run `terraform init` in this repo. This will initialize Terraform and get us ready to run Terraform plans.
1. Run `doctl auth init` to login to DigitalOcean. This will get us ready to pull data from DigitalOcean.
1. Get an API token from your DigitalOcean account from https://cloud.digitalocean.com/account/api/tokens
1. Set it to `DIGITALOCEAN_TOKEN` in your terminal environment with `export DIGITALOCEAN_TOKEN=<your token>`. This will be used by Terraform.
1. Run `terraform plan -out plan.tfplan` to plan this Terraform application.
1. Run `terraform apply "plan.tfplan"` to apply this to your DigitalOcean account. This will launch a K8s cluster, a Postgres DB, and a Redis DB. This can take a long time to run. Note the Postgres and Redis databases are just for show, nothing is setup to use them.
1. Run `doctl kubernetes cluster kubeconfig save dcsil-cluster` to download the kubernetes config for the cluster we just launched (named dcsil-cluster).
1. Run `./launch.sh` to launch nginx/load balancers on your Kubernetes Cluster. This script will set up a DCSIL namespace, then launch our nginx application on Kubernetes. Next it will launch a LoadBalancer that is set up to serve data from any apps with the label "nginx". This script can take a while to run.
1. Go to the IP Address the script prints out. This should show the nginx page.
