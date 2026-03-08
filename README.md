# Born2beRoot

42 School system administration project - Setting up a Debian virtual machine with strict security configurations.

## Project Overview

This project introduces the world of virtualization and system administration. The goal is to create a fully functional Debian virtual machine following strict security rules and guidelines.

## VM Specifications

- **OS**: Debian (latest stable)
- **Disk**: At least 30GB
- **RAM**: Minimum 1GB
- **Partitioning**: Encrypted LVM with specific partitions

## Partitions

```
/           root
/home       home
/var        var
/tmp        tmp
/var/log    var-log
swap        swap
```

## Security Configuration

### 1. Sudo
- sudo installed and configured
- Strict rules for sudo usage
- Authentication on each sudo use

### 2. SSH
- SSH service running on port 4242
- Root login disabled
- SSH key authentication configured

### 3. Firewall
- UFW (Uncomplicated Firewall) installed
- Only port 4242 open for SSH

### 4. User Management
- Non-root user with sudo privileges
- Strong password policies enforced

### 5. Password Policy
- Password expires every 30 days
- Minimum 2 days before password modification
- Warning 7 days before expiration
- Minimum length: 10 characters
- Must contain: uppercase, lowercase, number
- Must not contain username
- No more than 3 consecutive identical characters
- Must not be same as previous password

### 6. Hostname
- Hostname: login42 (replace login with your username)
- Modifiable via script

## Monitoring Script

The `monitoring.sh` script displays system information every 10 minutes using wall:

- Operating System architecture
- CPU physical and virtual cores
- Memory usage (used/total + percentage)
- Disk usage (used/total + percentage)
- Current CPU load
- Last boot time
- LVM usage status
- Active TCP connections
- Logged in users count
- Network IP and MAC address
- Number of sudo commands executed

## Services Running

| Service | Purpose |
|---------|---------|
| SSH | Remote access (port 4242) |
| UFW | Firewall management |
| cron | Scheduled tasks (monitoring) |
| AppArmor | Mandatory Access Control |

## Useful Commands

```bash
# Check hostname
hostnamectl

# Check partitions
lsblk

# Check sudo configuration
sudo -V

# Check UFW status
sudo ufw status

# Check SSH status
sudo systemctl status ssh

# Check cron jobs
sudo crontab -l

# Check AppArmor status
sudo aa-status
```

## Signature

At the end of the project, generate a signature.txt file containing the SHA1 hash of the VM's .vdi file:

```bash
sha1sum your_vm.vdi > signature.txt
```

## Resources

- [Debian Documentation](https://www.debian.org/doc/)
- [42 Born2beRoot Subject](./Born2beRoot.en.subject.pdf)
- [AppArmor Wiki](https://gitlab.com/apparmor/apparmor/-/wikis/Documentation)

## Author

42 School Project - Born2beRoot
