FROM node:8.12.0-alpine AS node
FROM ruby:2.5.1-alpine

RUN mkdir /opt

COPY --from=node /opt/yarn-v1.9.4 /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg

ENV LANG C.UTF-8

RUN apk update \
  && apk add ca-certificates wget \
  && update-ca-certificates

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev vim
RUN apk update && \
  apk upgrade && \
  apk add --update --no-cache --virtual build-dependencies \
  build-base \
  curl-dev \
  linux-headers \
  libxml2-dev \
  libxslt-dev \
  mysql-dev \
  ruby-dev \
  yaml-dev \
  zlib-dev && \
  apk add --update --no-cache \
  bash \
  git \
  openssh \
  ruby-json \
  tzdata \
  mysql-client \
  yaml \
  less \
  vim \
  imagemagick

RUN mkdir /farmally
WORKDIR /farmally

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install
COPY . /farmally

RUN yarn install
RUN yarn build

#RUN rails assets:precompile RAILS_ENV=production
