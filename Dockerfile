FROM nginx:stable-alpine


RUN apk update && apk add --no-cache openssh bash shadow

RUN echo "root:aryaman" | chpasswd


RUN sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config


RUN ssh-keygen -A
RUN mkdir -p /var/run/sshd

EXPOSE 22 80

CMD ["/bin/bash", "-c", "/usr/sbin/sshd && nginx -g 'daemon off;'"]