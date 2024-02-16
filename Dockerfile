FROM debian:bullseye

RUN apt update && \
    apt install -y wget && \
    apt install -y curl && \
    apt install -y unzip

RUN curl -s -L -o hashicorp_zip.zip $(curl -s -L https://releases.hashicorp.com$(curl -s https://releases.hashicorp.com/consul-template/ | grep 'consul-template/' | head -n 1 | sed 's#.*href=\"\(.*\)\">.*#\1#') | grep linux | grep "$( [ $(uname -m) = aarch64 ] && echo arm64 || echo amd64)" | sed 's#.*href=\"\(.*\)\">.*#\1#')
RUN unzip hashicorp_zip.zip
RUN mv consul-template /usr/bin/

#ENTRYPOINT "/usr/bin/consul-template"
CMD ["/usr/bin/consul-template"]
