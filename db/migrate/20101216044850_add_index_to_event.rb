class AddIndexToEvent < ActiveRecord::Migration
  def self.up
  	add_index :events, :user_id
  end

  def self.down
  	remove_index :events, :user_id
  end
end
