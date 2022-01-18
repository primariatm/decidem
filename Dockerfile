FROM ruby:2.7.4-alpine

ARG UID
ARG GID

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV BUNDLER_VERSION 2.2.18
ENV NODE_VERSION 16.9.1

RUN apk add --update postgresql-dev tzdata build-base autoconf bison imagemagick bash git npm
RUN apk --no-cache add nodejs-current yarn --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community

RUN npm install -g n
RUN n $NODE_VERSION

RUN echo 'gem: --no-rdoc --no-ri' >> "/etc/gemrc"
RUN gem install bundler --version $BUNDLER_VERSION

RUN addgroup --gid $GID decidem
RUN adduser -D -g '' -u $UID -G decidem decidem

ENV app /home/decidem/app
RUN mkdir $app
WORKDIR $app
COPY . $app

RUN bundle install --jobs=4 --retry=3
RUN yarn install && yarn cache clean --force
RUN bundle exec rails webpacker:compile

RUN mkdir storage
RUN chown -R decidem:decidem $app
USER $UID

EXPOSE 3000

ENTRYPOINT []

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
