web: puma -C config/puma.rb
worker: bundle exec sidekiq -C config/sidekiq.yml
release: rake db:migrate
