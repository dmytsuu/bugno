# frozen_string_literal: true

server Rails.application.credentials.production_server_ip, user: Rails.application.credentials.production_server_user, roles: %w[app db web]
set :rails_env, 'production'
set :branch, 'master'
