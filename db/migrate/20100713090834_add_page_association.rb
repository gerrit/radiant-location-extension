class AddPageAssociation < ActiveRecord::Migration
  def self.up
    add_column :locations, :page_id, :integer
    Location.all.each do |location|
      if location.page_path && page = Page.find_by_url(location.page_path)
        location.update_attribute :page_id, page.id
      end
    end
    remove_column :locations, :page_path
  end

  def self.down
    add_column :locations, :page_path, :string
    Location.all.each do |location|
      if location.page_id && page = Page.find(location.page_id)
        location.update_attribute :page_path, page.url
      end
    end
    remove_column :locations, :page_id
  end
end
