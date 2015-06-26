class AddIndexToUsersUsername < ActiveRecord::Migration
  def change
    add_index :users, :username, unique: true
    add_column :users, :karma, :integer
  end
end
