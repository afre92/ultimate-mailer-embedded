class AddOrderNumberToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_number, :string, default: ''
  end
end
