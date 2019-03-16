# You may specify any image tag from https://hub.docker.com/r/library/ruby/tags
ARG VERSION_RUBY=2.5
FROM ruby:${VERSION_RUBY}

# Some labels conforming to RC1 of label-schema from https://label-schema.org
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.name="containaruba" \
      org.label-schema.description="Aruba, the Cucumber CLI testing extension, containerized!" \
      org.label-schema.usage="/README.md" \
      org.label-schema.url="https://github.com/Nekroze/containaruba" \
      org.label-schema.vcs-url="https://github.com/Nekroze/containaruba.git" \
      org.label-schema.vendor="Taylor 'Nekroze' Lawson <https://keybase.io/nekroze>"

# You may specify specific versions or a version selector, by default the
# version or newer described below.
ARG VERSION_ARUBA='~> 0.14.8'
ARG VERSION_CUCUMBER_LINT='~> 0.1.2'
ARG VERSION_DOCKER_COMPOSE='1.22.0'

RUN echo "Installing Docker-CE" \
 && apt-get update \
 && apt-get install -y \
   apt-transport-https \
   ca-certificates \
   curl \
   gnupg2 \
   software-properties-common \
   bsdmainutils \
 && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
 && apt-key fingerprint 0EBFCD88 \
 &&  add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable" \
 && apt-get update \
 && apt-get install -y docker-ce \
 && rm -rf /var/lib/apt/lists/*

RUN echo "Installing Docker Compose" \
 && curl -L "https://github.com/docker/compose/releases/download/${VERSION_DOCKER_COMPOSE}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
 && chmod +x /usr/local/bin/docker-compose

RUN echo "Installing Gem's Aruba and Cucumber Lint" \
 && gem install cucumber_lint -v "${VERSION_CUCUMBER_LINT}" \
 && gem install aruba -v "${VERSION_ARUBA}" \
 && mkdir -p /usr/src/app \
 && chmod 777 /usr/src/app

VOLUME /output
RUN chmod 777 /output

COPY ./entrypoint.sh ./README.md /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["features"]

# This is where you should add or mount your feature files.
VOLUME /usr/src/app/features
WORKDIR /usr/src/app
