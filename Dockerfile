FROM ruby:2.5.1-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache \
        libffi-dev \
        git \
        make \
        gcc \
        libc-dev \
        g++

ENV LANG=C.UTF-8

WORKDIR /usr/src/app

RUN gem install bundler

COPY Gemfile* ./
RUN bundle install

COPY . .

CMD ["ruby", "/usr/src/app/app.rb"]
