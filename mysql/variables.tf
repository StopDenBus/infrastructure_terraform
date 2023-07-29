variable "admin_password" {
    type = string
    sensitive = true
}

variable admin_username {
    type = string
    default = "root"
}

variable "databases" {
    type = map(object({
        default_character_set = optional(string, "utf8mb3")
        default_collation = optional(string, "utf8mb3_general_ci")
    }))
    default = {
    }
}

variable endpoint {
    type = string
    default = "stoppi.gusek.info:32306"
}

variable "secrets" {
    type = map(object({
        key = string
    }))
    sensitive = true
}

variable "users" {
    type = map(object({
        host = optional(string, "%")
        privileges = list(object({
            database = string
            grant = list(string)
        }))
    }))
}

