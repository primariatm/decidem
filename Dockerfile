######################
# Stage: Builder
FROM ruby:2.7.4-alpine as builder

ARG GID
ARG UID
ARG RAILS_ENV

RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    git \
    npm \
    bash \
    yarn \
    imagemagick \
    tzdata
RUN apk --no-cache add nodejs-current yarn --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community

ENV BUNDLER_VERSION 2.2.18
RUN echo 'gem: --no-rdoc --no-ri' >> "/etc/gemrc"
RUN gem install bundler --version $BUNDLER_VERSION

RUN addgroup --gid $GID decidem && adduser -D -g '' -u $UID -G decidem decidem

ENV app /home/decidem/app

WORKDIR $app
COPY . $app

# Install gems
RUN bundle config --global frozen 1 \
    && bundle config set --local without 'development test' \
    && bundle install --jobs 4 --retry 3 \
    # Remove unneeded files (cached *.gem, *.o, *.c) \
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

RUN yarn install
RUN RAILS_ENV=$RAILS_ENV SECRET_KEY_BASE=foo bundle exec rails webpacker:compile

# Remove folders not needed in resulting image
RUN rm -rf node_modules tmp/cache

###############################
# Stage wkhtmltopdf
FROM madnight/docker-alpine-wkhtmltopdf as wkhtmltopdf

###############################
# Stage Final
FROM ruby:2.7.4-alpine

ARG GID
ARG UID

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV app /home/decidem/app

# Add Alpine packages
RUN apk add --update --no-cache \
    postgresql-client \
    imagemagick \
    tzdata \
    file \
    bash \
    # needed for wkhtmltopdf
    libressl3.3-libcrypto \
    ttf-dejavu ttf-droid ttf-freefont ttf-liberation

# Copy wkhtmltopdf from former build stage
COPY --from=wkhtmltopdf /bin/wkhtmltopdf /bin/

RUN addgroup --gid $GID decidem && adduser -D -g '' -u $UID -G decidem decidem
USER decidem

# Copy app with gems from former build stage
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder --chown=decidem:decidem /home/decidem/app $app

WORKDIR $app

EXPOSE 3000

ENTRYPOINT []

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
