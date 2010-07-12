class AddMoreFieldsToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :tel, :string
    add_column :locations, :email, :string
    add_column :locations, :postal_code, :string
    add_column :locations, :locality, :string
    add_column :locations, :street_address, :string
    add_column :locations, :region, :string
    add_column :locations, :country_name, :string
  end

  def self.down
    remove_column :locations, :country_name
    remove_column :locations, :region
    remove_column :locations, :street_address
    remove_column :locations, :locality
    remove_column :locations, :postal_code
    remove_column :locations, :email
    remove_column :locations, :tel
  end
end
