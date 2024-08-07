class RemoveUniqueIndexOnEmailFromWaivers < ActiveRecord::Migration[7.2]
  def change
    remove_index :waivers, column: :email, name: "index_waivers_on_email"
  end
end
