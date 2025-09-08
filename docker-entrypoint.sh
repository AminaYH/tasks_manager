#!/bin/bash
set -e

cd /rails || exit 1

export PATH="/usr/local/bundle/bin:$PATH"

[ -f tmp/pids/server.pid ] && rm -f tmp/pids/server.pid

dev_setup() {
  bundle config unset without
  bundle config unset frozen         
  bundle config set --local with 'development test'
  bundle install                    
  yarn install --check-files
  bundle exec rails assets:precompile
}

db_setup() {
  if [ -n "$POSTGRES_HOST" ]; then
    echo "Waiting for $POSTGRES_HOST:${POSTGRES_PORT:-5432} ..."
    until nc -z "$POSTGRES_HOST" ${POSTGRES_PORT:-5432}; do
      sleep 1
    done
  fi
  bundle exec rails db:create db:migrate 2>/dev/null || true
  bundle exec rails db:seed 2>/dev/null || true
}

dev_setup
db_setup

case "$RAILS_ENV" in
  development)
    yarn build:watch &
    yarn watch:css &
    exec bundle exec rails server -b 0.0.0.0 -p 3000
    ;;
  test)
    exec bundle exec guard --no-notify --no-interactions --clear
    ;;
  *)
    echo "Invalid RAILS_ENV: $RAILS_ENV (use development/test)"
    exit 1
    ;;
esac
