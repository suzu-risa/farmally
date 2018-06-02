FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /farmally
WORKDIR /farmally

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install
COPY . /farmally
