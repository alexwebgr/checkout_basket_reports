Apipie.configure do |config|
  config.app_name                = "CheckoutBasket"
  config.app_info                = "Endpoint docs"
  config.api_base_url            = "/"
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.translate = false
end
