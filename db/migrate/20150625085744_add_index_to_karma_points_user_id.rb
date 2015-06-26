class AddIndexToKarmaPointsUserId < ActiveRecord::Migration
  def change
    add_index :karma_points, :user_id, unique: true
  end
end
