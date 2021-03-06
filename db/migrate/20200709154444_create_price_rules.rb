class CreatePriceRules < ActiveRecord::Migration[5.2]
  def change
    create_table :price_rules do |t|
      t.belongs_to :shop
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :active, default: false
      t.string :title
      t.integer :value
      t.integer :value_type
      t.string :shopify_id

      t.timestamps
    end
  end
end
