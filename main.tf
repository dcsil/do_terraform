terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
}

#####
# K8s Cluster
#####

data "digitalocean_kubernetes_versions" "dcsil-cluster" {}

output "k8s-versions" {
  value = data.digitalocean_kubernetes_versions.dcsil-cluster.valid_versions
}

resource "digitalocean_kubernetes_cluster" "dcsil-cluster" {
  name    = "dcsil-cluster"
  region  = "tor1"
  version = data.digitalocean_kubernetes_versions.dcsil-cluster.latest_version

  node_pool {
    name       = "autoscale-worker-pool"
    size       = "s-1vcpu-2gb"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 5
  }
}

#####
# Postgres
#####

resource "digitalocean_database_db" "dcsil-database" {
  cluster_id = digitalocean_database_cluster.postgres-dcsil.id
  name       = "dcsil-db"
}

resource "digitalocean_database_cluster" "postgres-dcsil" {
  name       = "dcsil-postgres-cluster"
  engine     = "pg"
  version    = "13"
  size       = "db-s-1vcpu-1gb"
  region     = "tor1"
  node_count = 1
}

#####
# Redis
#####

resource "digitalocean_database_cluster" "redis-dcsil" {
  name       = "dcsil-redis-cluster"
  engine     = "redis"
  version    = "6"
  size       = "db-s-1vcpu-1gb"
  region     = "tor1"
  node_count = 1
}

