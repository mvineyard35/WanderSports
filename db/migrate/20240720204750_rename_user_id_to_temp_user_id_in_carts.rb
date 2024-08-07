class RenameUserIdToTempUserIdInCarts < ActiveRecord::Migration[7.2]
  def change
    rename_column :carts, :user_id, :temp_user_id
    rename_index :carts, 'index_carts_on_user_id', 'index_carts_on_temp_user_id'
  end
end
