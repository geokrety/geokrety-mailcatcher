ARG BASE_IMAGE_TAG=alpine
FROM ruby:${BASE_IMAGE_TAG}

ARG MAILCATCHER_VERSION=${MAILCATCHER_VERSION:-0.10.0}
RUN apk --no-cache --update add \
        build-base \
        ruby-dev \
        sqlite-dev \
        gcompat \
 && [ "$(uname -m)" != "aarch64" ] || gem install sqlite3 --version="~> 1.3" --no-document --platform ruby \
 && gem install mailcatcher:${MAILCATCHER_VERSION} --no-document \
 && apk del --rdepends --purge build-base

EXPOSE 25 80
CMD ["mailcatcher", "-f", "--ip", "0.0.0.0", "--http-port", "80", "--smtp-port", "25"]
