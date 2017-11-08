
Rails.application.configure do
  config.cache_classes = true
  config.secret_key_base = 'asdfashfisudyboiuhsdlfkjashldkfjhskldfjh'
  config.secret_token = 'asdvfiuyslkjasdfhlflfll12341245124o58726340'
  config.eager_load = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true
  config.action_dispatch.rack_cache = true
  config.serve_static_files = true # ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.log_level = :debug
  config.cache_store = :file_store, "tmp/cache/rails-cache" # :mem_cache_store
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
end

Paperclip.options[:image_magick_path] = "/usr/bin"
Paperclip.options[:command_path] = "/usr/bin"
