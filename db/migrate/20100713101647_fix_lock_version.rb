class FixLockVersion < ActiveRecord::Migration
  def self.up
    change_column :locations, :lock_version, :integer, :default => 0
  end

  def self.down
    change_column :locations, :lock_version, :integer
  end
end
