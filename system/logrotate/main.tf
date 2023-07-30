# Create virtual host configuration
resource "system_file" "logrotate" {
    for_each = var.log_rotate

    path = "/etc/logrotate.d/${each.key}"
    content = trimspace(each.value["config"])
}