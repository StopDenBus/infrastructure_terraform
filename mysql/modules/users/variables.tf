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