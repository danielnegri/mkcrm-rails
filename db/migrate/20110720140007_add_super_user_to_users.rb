class AddSuperUserToUsers < ActiveRecord::Migration
  def self.up
    # Users - Super Users
    add_column :users, :super_user, :boolean, :default => false
  end

  def self.down
    remove_column :users, :super_user
  end
end
