class CreateTempusers < ActiveRecord::Migration[7.2]
  def change
    create_table :temp_users do |t|
      t.timestamps
    end
  end
end
