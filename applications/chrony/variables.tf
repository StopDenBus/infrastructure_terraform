variable host {
    type = string
}

variable private_key {
    type = string
    default = "~/.ssh/id_ed25519"
}

variable "ntp_pools" {
    type    = list(string)
    default = [ ]
}

variable "ntp_servers" {
    type    = list(string)
    default = [ ]
}

variable "ntp_additional_configuration" {
    type    = list(string)
    default = [ ]
}

variable port {
    type = number
    default = 22
}

variable user {
    type = string
    default = "root"
}