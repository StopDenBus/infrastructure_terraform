variable "secrets" {
    type = map(object({
        mount = optional(string, "secrets")
        name = string
    }))
    default = {
    }
}