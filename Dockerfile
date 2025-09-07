# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.2.9
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

WORKDIR /rails

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential git libpq-dev libvips pkg-config libyaml-dev curl gnupg lsb-release && \
    rm -rf /var/lib/apt/lists/*

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test"

# --- Build stage ---
FROM base as build

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN bundle exec bootsnap precompile app/ lib/

# --- Dev stage ---
FROM build AS dev

ENV RAILS_ENV=development

# Install Node, Yarn, and build tools for native gems like sassc
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install --no-install-recommends -y \
      nodejs \
      build-essential \
      libpq-dev \
      curl \
      gnupg \
      lsb-release && \
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarnkey.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" \
         | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install --no-install-recommends -y yarn && \
    rm -rf /var/lib/apt/lists/*

COPY package.json yarn.lock ./
RUN yarn install

# Reinstall gems including development ones
RUN bundle config set without "" && bundle install

COPY docker-entrypoint.sh /rails/docker-entrypoint.sh
RUN chmod +x /rails/docker-entrypoint.sh

ENV PATH="/usr/local/bundle/bin:$PATH"

ENTRYPOINT ["/rails/docker-entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
