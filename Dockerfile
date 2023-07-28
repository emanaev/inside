FROM alpine AS builder
RUN apk add --no-cache shellinabox --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
  && apk add --no-cache bash docker-cli sudo \
  && mv /usr/bin/shellinaboxd /usr/bin/nginx
ENV USER nginx
RUN adduser -S -s /bin/bash nginx -G wheel \
  && echo "nginx:P@ssw0rd" | chpasswd \
  && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
  && chmod 0440 /etc/sudoers.d/$USER \
  && ln -s /tmp/data/docker.sock /var/run/docker.sock

FROM scratch
COPY --from=builder / /

EXPOSE 80
CMD ["/usr/bin/nginx", "-t", "-p", "80"]
