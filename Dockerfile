FROM ruby:2.6.3-alpine3.9 AS builder

ENV RAILS_ENV production

WORKDIR /app

RUN apk add --update --no-cache \
    build-base \
    libxml2-dev \
    libxslt-dev \
    sqlite-dev \
    nodejs \
    yarn \
    tzdata

RUN gem install bundler
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install --clean --frozen --jobs $(nproc)  --without development test

COPY Rakefile .
COPY bin bin
COPY config config
COPY app/assets app/assets
RUN bin/rails assets:precompile

FROM ruby:2.6.3-alpine3.9

ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT 1
ENV RAILS_SERVE_STATIC_FILES 1

WORKDIR /app

RUN apk add --update --no-cache \
    sqlite-libs \
    tzdata

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app/public/assets /app/public/assets
COPY . .

RUN bin/rails db:schema:load

EXPOSE 3000
ENTRYPOINT ["bin/rails"]
