#!/usr/bin/env bash
./bin/rails db:migrate
./bin/rails data_migration:exec
./bin/rails assets:precompile
./bin/bundle exec whenever --update-crontab -s "environment=$RAILS_ENV"
./bin/rails s
