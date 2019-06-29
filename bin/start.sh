#!/usr/bin/env bash
./bin/rails db:migrate
./bin/rails data_migration:exec
./bin/rails assets:precompile --trace
./bin/rails s
