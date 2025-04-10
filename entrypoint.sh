#!/bin/bash
if [ -n "$SSH_PUBLIC_KEY" ]; then
  echo "$SSH_PUBLIC_KEY" > /home/sshuser/.ssh/authorized_keys
  chown sshuser:sshuser /home/sshuser/.ssh/authorized_keys
  chmod 600 /home/sshuser/.ssh/authorized_keys
fi
/usr/sbin/sshd
serve -s /app/build -l 3000
