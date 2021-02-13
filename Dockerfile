FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

# curl & jq & envsubst (included in gettext-base)
RUN apt-get update -y \
  && apt-get install -y --no-install-recommends curl gettext-base jq bash dnsutils ca-certificates \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /tmp/* /var/tmp/* /var/cache/apt/archives/* /var/lib/apt/lists/*

# kubectl
RUN apt-get update -y \
  && apt-get install -y apt-transport-https gnupg2 curl \
  && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
  && apt-get update \
  && apt-get install -y kubectl \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /tmp/* /var/tmp/* /var/cache/apt/archives/* /var/lib/apt/lists/*

# yq
ENV YQ_VERSION=4.5.1
ENV YQ_BINARY=yq_linux_amd64
RUN curl -s -L https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/${YQ_BINARY}.tar.gz \
  | tar -xz \
  && mv ${YQ_BINARY} /usr/bin/yq
