# FROM nginx:stable-alpine


# RUN apk update && apk add --no-cache openssh bash shadow

# RUN echo "root:aryaman" | chpasswd


# RUN sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
#     sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config


# RUN ssh-keygen -A
# RUN mkdir -p /var/run/sshd

# EXPOSE 22 80

# CMD ["/bin/bash", "-c", "/usr/sbin/sshd && nginx -g 'daemon off;'"]





# FROM nginx:stable-alpine
# RUN apk update && apk add --no-cache openssh bash shadow
# RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh
# COPY id_rsa.pub /root/.ssh/authorized_keys

# RUN chmod 600 /root/.ssh/authorized_keys && \
#     chown -R root:root /root/.ssh
#     #in this s is used to subsitute 
#     # -i means inspace edit 
#     # ^ start of line

# RUN sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
#     sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
# RUN ssh-keygen -A
# RUN mkdir -p /var/run/sshd
# EXPOSE 22 80
# CMD ["/bin/bash", "-c", "/usr/sbin/sshd && nginx -g 'daemon off;'"]

# # log rotator





FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    nginx \
    openssh-server \
    bash \
    && apt-get clean


RUN mkdir -p /var/run/sshd \
    && mkdir -p /root/.ssh \
    && chmod 700 /root/.ssh

COPY id_rsa.pub /root/.ssh/authorized_keys

RUN chmod 600 /root/.ssh/authorized_keys && \
    chown -R root:root /root/.ssh

RUN sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config


RUN ssh-keygen -A


EXPOSE 22 80
CMD ["/bin/bash", "-c", "/usr/sbin/sshd && nginx -g 'daemon off;'"]
