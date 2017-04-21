PayPal::SDK.load("config/paypal.yml", Rails.env)
PayPal::SDK.logger = Rails.logger

if Rails.env.development?
  ::PAYPAL_CONFIG = {}
elsif Rails.env.production?
  ::PAYPAL_CONFIG = {}
elsif Rails.env.test?
  ::PAYPAL_CONFIG = {
    :mode => 'sandbox',
    :client_id => 'AYGZKBquUOZ8exH6Hev7r831dLcLGaF-M8jLdMgHkyb6hhsuEtLa9kwX5DZv2FgQboYa7W2Bzw4lG54b',
    :client_secret => 'EFD2-w4ZXwPpiR-13acTXFdbuqoi0qMT3Hl9NVzwAFIchFLK_esnglflPB3SrhPYu_vYs8l30HiL9mvW'
  }
else
  raise 'what environment is this?'
end
