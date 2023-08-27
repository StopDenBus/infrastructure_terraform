locals {
  ntp_pools_md5sums = flatten([
    for pool in var.ntp_pools: [
        resource.system_file.ntp_pools[pool].md5sum
    ]
  ])

  ntp_servers_md5sums = flatten([
    for pool in var.ntp_servers: [
        resource.system_file.ntp_servers[pool].md5sum
    ]
  ])

  md5sums = flatten([ local.ntp_pools_md5sums, local.ntp_servers_md5sums, [ resource.system_file.additional_configuration.md5sum ] ])
}

# Install chrony
resource "system_packages_apt" "chrony" {
    package {
        name = "chrony"
    }
}

resource "system_file" "ntp_pools" {
    for_each = toset(var.ntp_pools)

    path = "/etc/chrony/sources.d/${each.key}.sources"
    content = "pool ${each.key} iburst\n"
    
    depends_on = [
        system_packages_apt.chrony,
    ]
}

resource "system_file" "ntp_servers" {
    for_each = toset(var.ntp_servers)

    path = "/etc/chrony/sources.d/${each.key}.sources"
    content = "server ${each.key} iburst\n"

    depends_on = [
        system_packages_apt.chrony,
    ]
}

resource "system_file" "additional_configuration" {
    path = "/etc/chrony/conf.d/additional.conf"
    content = join("\n", var.ntp_additional_configuration)

    depends_on = [
        system_packages_apt.chrony,
    ]
}

resource "system_link" "chrony_conf" {
    path    = "/etc/chrony/chrony.conf"
    target  = "/usr/share/chrony/chrony.conf"
}

resource "system_link" "chrony_keys" {
    path    = "/etc/chrony/chrony.keys"
    target  = "/usr/share/chrony/chrony.keys"
}

resource "system_service_systemd" "chrony" {
    name      = "chrony"
    status    = "started"
    enabled  = true

    restart_on = local.md5sums

    depends_on = [
        system_packages_apt.chrony,
    ]
}
