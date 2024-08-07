class ChangeTempUserIdToReferenceInCarts < ActiveRecord::Migration[7.2]
  def change
    # First, remove the current integer column
    remove_column :carts, :temp_user_id, :integer

    # Add the reference (which is a more comprehensive way to define a foreign key in Rails)
    add_reference :carts, :temp_user, foreign_key: true, index: true
  end
end
