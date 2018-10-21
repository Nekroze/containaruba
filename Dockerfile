FROM alpine:latest

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
ARG VERSION_ARUBA='~> 0.14.6'
ARG VERSION_CUCUMBER_LINT='~> 0.1.2'

RUN apk add --no-cache docker python3 ca-certificates curl git openssh util-linux ruby ruby-dev bash gmp-dev alpine-sdk \
 && rm -f /usr/bin/dockerd /usr/bin/docker-containerd* \
 && pip3 install docker-compose

RUN echo "Installing Gem's Aruba and Cucumber Lint" \
 && apk add --no-cache ruby-rdoc \
 && gem install cucumber_lint -v "${VERSION_CUCUMBER_LINT}" \
 && gem install aruba -v "${VERSION_ARUBA}" \
 && mkdir -p /usr/src/app \
 && chmod 777 /usr/src/app

COPY ./entrypoint.sh ./README.md /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["features"]

# This is where you should add or mount your feature files.
VOLUME /usr/src/app/features
WORKDIR /usr/src/app
