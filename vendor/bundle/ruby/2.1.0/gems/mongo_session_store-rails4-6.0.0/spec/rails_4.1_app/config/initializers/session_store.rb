# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_rails_41_app_session'
MongoStore::Session.database = Mongo::Client.new(['127.0.0.1:27017'], database: "rails41_app_#{Rails.env}") if ENV['MONGO_SESSION_STORE_ORM'] == "mongo"
Rails.application.config.session_store :"#{ENV['MONGO_SESSION_STORE_ORM']}_store"
