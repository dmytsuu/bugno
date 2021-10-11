release: bundle exec rails db:prepare
web: bundle exec rails server -p $PORT
worker: bundle exec sidekiq -c 5 -v
