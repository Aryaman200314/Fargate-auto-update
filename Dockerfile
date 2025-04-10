FROM node:18 as builder
WORKDIR /app
COPY . .
RUN npm install && npm run build
FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y openssh-server curl && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g serve && \
    mkdir /var/run/sshd
WORKDIR /app
COPY --from=builder /app/build /app/build
RUN useradd -m -s /bin/bash sshuser && \
    mkdir -p /home/sshuser/.ssh && \
    chown sshuser:sshuser /home/sshuser/.ssh && \
    chmod 700 /home/sshuser/.ssh && \
    echo 'sshuser:sshpassword' | chpasswd
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 22 3000
CMD ["/entrypoint.sh"]
