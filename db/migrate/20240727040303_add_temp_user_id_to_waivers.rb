class AddTempUserIdToWaivers < ActiveRecord::Migration[7.2]
  def change
    add_column :waivers, :temp_user_id, :integer
  end
end
