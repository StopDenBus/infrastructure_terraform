output "ssh_mounts" {
 value = vault_mount.mount["ssh"].path
}