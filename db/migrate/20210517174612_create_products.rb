class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.decimal :price, precision: 6,scale: 2, default: 0
      t.bigint :instock_quantity

      t.timestamps
    end
  end
end

