provider "hcloud" {
  token = var.hcloud_token
}

provider "kubernetes" {
  host = module.kube-hetzner.kubeconfig_data.host

  client_certificate     = module.kube-hetzner.kubeconfig_data.client_certificate
  client_key             = module.kube-hetzner.kubeconfig_data.client_key
  cluster_ca_certificate = module.kube-hetzner.kubeconfig_data.cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host = module.kube-hetzner.kubeconfig_data.host

    client_certificate     = module.kube-hetzner.kubeconfig_data.client_certificate
    client_key             = module.kube-hetzner.kubeconfig_data.client_key
    cluster_ca_certificate = module.kube-hetzner.kubeconfig_data.cluster_ca_certificate
  }
}

