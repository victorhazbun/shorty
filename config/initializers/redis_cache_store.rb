Rails.application.configure do
  config.cache_store = :redis_cache_store, { url: ENV['REDIS_TLS_URL'] }
end
