class AddStoreIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :store_id, :bigint
  end
end
