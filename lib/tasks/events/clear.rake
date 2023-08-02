namespace :events do
    desc 'Remove outdated events'
    task clear: :environment do
        events = Event.where('created_at < ?', 2.weeks.ago).delete_all
        Rails.logger.info('Daily event cleanup executed.')
    end
end