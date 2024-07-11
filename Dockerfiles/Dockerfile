
FROM alpine:3.20.1 as base

ENV aws_cli_url https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
ENV gh_runner_url https://github.com/actions/runner/releases/download/v2.317.0/actions-runner-linux-x64-2.317.0.tar.gz

WORKDIR /home/runner

# ARG DEBIAN_FRONTEND=noninteractive
# ARG DEBCONF_NONINTERACTIVE_SEEN=true
# ARG NODE_JS_VERSION=16

RUN apk add --no-cache \
        curl \
        jq \
        ca-certificates \
        gnupg \
        lsb-release \
        #software-properties-common \
        #apt-utils \
        #apt-transport-https \
      # build-essential \
        # python3 \
        # python3-pip \
        # postgresql-client \
        git \
        openrc\
        openssh \
        zip \
        unzip \ 
        wget \
        file \
        #libicu-dev \
        icu-dev \
        # # rsync \
       # libgtk2.0-0 \
       # libgtk-3-0 \
       # libgbm-dev \
       # libnotify-dev \
        #libgconf-2-4 \
       #slibnss3 \
       # libxss1 \
       # libasound2 \
       # libxtst6 \
        xauth \
        xvfb \
        aws-cli
    # && curl -fsSL https://deb.nodesource.com/setup_${NODE_JS_VERSION}.x | bash - \
    # && apt-get install -y --no-install-recommends nodejs \
    # && npm i --location=global npm@latest \
    # && npm i --location=global corepack \
    # && corepack enable \
   # && apt-get autoremove -y \
   # && apt-get autoclean -y \
    #&& rm -rf /var/lib/apt/lists/*

# FROM base as cloud-base

# ARG VAULT_VERSION=1.8.5

# RUN export CURRENT_ARCH="amd64" \
#     && curl ${aws_cli_url} -o awscliv2.zip \
#     && unzip awscliv2.zip \
#     && ./aws/install \
#     && rm -rf ./aws awscliv2.zip \
#     && aws --version

FROM base as runner-base

# ARG RUNNER_VERSION=2.295.0
# ARG DEBIAN_FRONTEND=noninteractive
# ARG DEBCONF_NONINTERACTIVE_SEEN=true

RUN curl -o actions-runner.tar.gz -sL ${gh_runner_url} \
    && adduser -h /home/runner -H -D runner \
   #&& echo "runner ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers \
    # && mkdir -p /opt/hostedtoolcache \
    # && chown runner:runner /opt/hostedtoolcache \
    # && chmod g+rwx /opt/hostedtoolcache \
     && tar xzf ./actions-runner.tar.gz \
     && rm actions-runner.tar.gz \
     && cat ./bin/installdependencies.sh \
    # && ./bin/installdependencies.sh \
    && rm -rf /var/cache/apk/*

#COPY health-check /usr/bin/
COPY start.sh .
#COPY hello.world.sh .

USER runner

#VOLUME ["/opt/hostedtoolcache"]

ENTRYPOINT ["/home/runner/start.sh"]
#ENTRYPOINT [ "/home/runner/hello.world.sh" ]
