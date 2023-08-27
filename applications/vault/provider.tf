provider "linux" {
    host     = var.host
    port     = var.port
    user     = var.user
    private_key = file(var.private_key)
}

provider "system" {
    ssh {
        host = var.host
        port = var.port
        user = var.user
        private_key = file(var.private_key)
    }
}
