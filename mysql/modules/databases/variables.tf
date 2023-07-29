variable "databases" {
    type = map(object({
        default_character_set = optional(string, "utf8mb3")
        default_collation = optional(string, "utf8mb3_general_ci")
    }))
    default = {
    }
}