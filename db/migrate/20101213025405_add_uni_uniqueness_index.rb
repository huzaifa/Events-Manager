class AddUniUniquenessIndex < ActiveRecord::Migration
  def self.up
		add_index :users, :uni, :unique => true
  end

  def self.down
		remove_index :users, :uni
  end
end
