FROM ruby:2.5.1

ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim

RUN mkdir /farmally
WORKDIR /farmally

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install
COPY . /farmally
