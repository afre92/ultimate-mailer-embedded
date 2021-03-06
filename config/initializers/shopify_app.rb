# frozen_string_literal: true

ShopifyApp.configure do |config|
  config.application_name = 'Ultimate Emailer app'
  config.root_url = '/embedded'
  config.api_key = ENV['SHOPIFY_API_KEY']
  config.secret = ENV['SHOPIFY_API_SECRET']
  config.old_secret = ''
  config.scope = 'read_products, read_orders, read_draft_orders, read_discounts, write_discounts, read_price_rules, write_price_rules, read_themes, write_themes, read_script_tags, write_script_tags' # Consult this page for more scope options:
  # https://help.shopify.com/en/api/getting-started/authentication/oauth/scopes
  config.embedded_app = true
  config.after_authenticate_job = false
  config.api_version = '2019-10'
  config.session_repository = Shop
  config.webhook_jobs_namespace = 'embedded'
  config.webhooks = [
    { topic: 'orders/create', address: "#{ENV['EMBEDDED_URL']}webhooks/order_create", format: 'json' }
  ]
end

# ShopifyApp::Utils.fetch_known_api_versions                        # Uncomment to fetch known api versions from shopify servers on boot
# ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown    # Uncomment to raise an error if attempting to use an api version that was not previously known
