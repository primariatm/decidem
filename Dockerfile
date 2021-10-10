FROM ruby:2.7.4-bullseye

ARG UID
ARG GID

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV BUNDLER_VERSION 2.2.18
ENV NODE_VERSION 16.9.1

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt update
RUN apt install -y nodejs
RUN npm install -g yarn n
RUN n $NODE_VERSION

RUN echo 'gem: --no-rdoc --no-ri' >> "/etc/gemrc"
RUN gem install bundler --version $BUNDLER_VERSION

RUN addgroup --gid $GID decidem
RUN adduser --disabled-password --gecos '' --uid $UID --gid $GID decidem

RUN mkdir /app

WORKDIR /app
COPY . /app

RUN npm install
RUN bundle check || bundle install
RUN bundle exec rails assets:precompile
RUN bundle exec rails webpacker:compile

RUN chown -R decidem:decidem /app
USER $UID

EXPOSE 3000

ENTRYPOINT []

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
