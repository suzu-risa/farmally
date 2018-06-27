#!/usr/bin/env bash
./bin/rails db:migrate
./bin/rails assets:precompile
./bin/rails s
