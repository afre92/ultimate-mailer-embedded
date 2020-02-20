# frozen_string_literal: true

class CreateShops < ActiveRecord::Migration[5.2]
  def self.up
    create_table :shops do |t|
      t.string :shopify_domain, null: false
      t.string :shopify_token, null: false
      t.string :web_token, default: ""
      t.timestamps
    end

    add_index :shops, :shopify_domain, unique: true
  end

  def self.down
    drop_table :shops
  end
end
