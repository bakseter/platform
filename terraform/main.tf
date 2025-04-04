provider "hcloud" {
  token = var.hcloud_token
}

module "kube-hetzner" {
  providers = {
    hcloud = hcloud
  }

  source  = "kube-hetzner/kube-hetzner/hcloud"
  version = "2.16.1"

  hcloud_token    = var.hcloud_token
  ssh_public_key  = var.ssh_public_key
  ssh_private_key = var.ssh_private_key

  control_plane_nodepools = [
    {
      name        = "control-plane",
      server_type = "cx22",
      location    = var.location
      labels      = [],
      taints      = [],
      count       = 1
    }
  ]

  agent_nodepools = [
    {
      name        = "agent",
      server_type = "cx22",
      location    = var.location
      labels      = [],
      taints      = [],
      count       = 1
    }
  ]

  network_region = "eu-central" # locations 'fns1', 'nbg1' and 'hel1'

  enable_klipper_metal_lb = "true"

  automatically_upgrade_k3s = false
  system_upgrade_use_drain  = true
  automatically_upgrade_os  = false

  disable_network_policy = true

  dns_servers = [
    "1.1.1.1",
    "8.8.8.8",
    "2606:4700:4700::1111",
  ]

  create_kubeconfig    = false
  create_kustomization = false
}
