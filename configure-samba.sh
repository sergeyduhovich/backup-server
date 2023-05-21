#!/usr/bin/env bash

# Set the Samba user and password
samba_user=${SAMBA_USER:-sambauser}
samba_password=${SAMBA_PASSWORD:-sambapassword}

echo $samba_user

# Update Samba configuration with the provided user and password

adduser --disabled-password --gecos "" $samba_user

echo -e "${samba_password}\n${samba_password}" | smbpasswd -a -s ${samba_user}

chown -R $samba_user:$samba_user /mnt/backups

echo -e "\n[backups]\n\tcomment = Backups\n\tpath = /mnt/backups/backups\n\tvalid users = $samba_user\n\tread only = no\n\tvfs objects = catia fruit streams_xattr\n\tfruit:time machine = yes" | tee -a /etc/samba/smb.conf

# Start the Samba service
service smbd start

service dbus start

service avahi-daemon start

# Keep the container running
tail -f /dev/null