variable host {
    type = string
}

variable private_key {
    type = string
    default = "~/.ssh/id_ed25519"
}

variable port {
    type = number
    default = 22
}

variable user {
    type = string
    default = "root"
}
