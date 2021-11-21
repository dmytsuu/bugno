# frozen_string_literal: true

require File.expand_path("./environment", __dir__)

lock '~> 3.16.0'
set :application, 'bugno'
set :repo_url, 'git@github.com:dmytsuu/bugno.git'
set :deploy_to, "/home/dmytsuu/#{fetch :application}"
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets',
       'vendor/bundle', '.bundle', 'public/system', 'public/uploads'
set :keep_releases, 5
