class AddGuardianNameToWaivers < ActiveRecord::Migration[7.2]
  def change
    add_column :waivers, :guardian_name, :string
  end
end
