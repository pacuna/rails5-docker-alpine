FROM ruby:2.4.2-alpine3.7
LABEL maintainer="pabloacuna88@gmail.com"

# Minimal requirements to run a Rails app
RUN apk add --no-cache --update ruby-nokogiri \
                                linux-headers \
                                build-base \
                                postgresql-dev \
                                nodejs \
                                tzdata

# Different layer for gems installation
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

# Copy the application into the container
COPY . /usr/src/app
WORKDIR /usr/src/app
EXPOSE 3000
