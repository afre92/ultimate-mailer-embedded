class AddPaymentStatusToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :payment_status, :integer, default: 0
    add_column :shops, :charge_id, :string, default: ''
  end
end
