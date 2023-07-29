variable address {
    type = string
    default = "https://vault.apps.gusek.info"
}

variable "mounts" {
    type = map
}

variable policies {
    type = map
}

variable "secrets" {
    type = map(object({
        mount = optional(string, "secrets")
        name = string
    }))
    default = {
    }
}

variable token {
    type = string
}
