# frozen_string_literal: true

class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  include TemplatesDefault
  has_many :templates, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :emails, dependent: :destroy
  has_many :reviews, through: :orders

  before_create :create_unique_token
  after_create :get_shop_info, :create_templates

  enum subscription_type: { free: 0, basic: 1, pro: 2 }

  def create_templates
    # Create Thank You Template
    Template.create(
      shop_id: id,
      from: email,
      reply_to: email,
      subject: "I really want to send you a special thanks for visiting our store",
      template_type: 'thank_you',
      body: thank_you_json,
      html: thank_you_html 
    )
    
    # Create Review Template
    Template.create(
      shop_id: id,
      from: email,
      reply_to: email,
      subject: "We'd love feedback on your recent #{shop_name} purchase",
      template_type: 'review',
      body: review_json,
      html: review_html
    )
  end

  def create_sample_dataset
    order = self.orders.new
    # create fake order with fake info and also create order items and customer(information needed to render templates on index)
  end

  def api_version
    ShopifyApp.configuration.api_version
  end

  def get_shop_info
    shop_info = ShopifyAPI::Session.temp(domain: shopify_domain, token: shopify_token, api_version: ShopifyApp.configuration.api_version) do
      ShopifyAPI::Shop.current
    end
    shop_info = shop_info.attributes

    self.email = shop_info['email']
    self.address = shop_info['address1']
    if shop_info['shop_owner'].include?(' ')
      self.owner_first_name, self.owner_last_name = shop_info['shop_owner'].split(' ')
    else
      self.owner_first_name = shop_info['shop_owner']
    end
    self.phone = shop_info['phone']
    self.shop_name = shop_info['name']
    self.timezone = shop_info['iana_timezone']
    save
  end

  def create_unique_token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      return (self.web_token = random_token) unless Shop.exists?(web_token: random_token)
    end
  end

end
