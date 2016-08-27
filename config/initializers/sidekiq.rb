namespace = Rails.application.class.parent_name.downcase + '_' + ENV.fetch('APP_ENV', Rails.env)
redis_config = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379'), namespace: namespace }
redis_config[:password] = ENV['REDIS_PASSWORD'] if ENV.key?('REDIS_PASSWORD')

unless Rails.env.test?
  Sidekiq.configure_client do |config|
    config.redis = redis_config
  end

  # sidekiq workers
  Sidekiq.configure_server do |config|
    config.redis = redis_config
  end
end
