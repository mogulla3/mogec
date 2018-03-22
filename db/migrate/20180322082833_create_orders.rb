class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :price
      t.references :user, foreign_key: true
      t.references :store, foreign_key: true
      t.datetime :ordered_at

      t.timestamps
    end
  end
end
