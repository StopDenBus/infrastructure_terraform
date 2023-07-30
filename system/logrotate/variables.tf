variable host {
    type = string
}

variable "log_rotate" {
    type = map(object({
        config = string
    }))
    default = {}
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
