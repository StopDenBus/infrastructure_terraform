provider "vault" {
    address = var.address
    token = var.token
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}