class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.string :order_status
      t.references :product, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
