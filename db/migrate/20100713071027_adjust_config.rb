class AdjustConfig < ActiveRecord::Migration
  def self.up
    active_fields = Location.optional_fields
    [:group, :website_url, :page_path].each do |field|
      active_fields.delete(field) unless Radiant::Config[key(field)]
      Radiant::Config.find_by_key(key(field)).try :destroy
    end
    Radiant::Config['locations.fields'] = active_fields.join(',')
  end

  def self.down
    if fields_config = Radiant::Config.find_by_key(key)
      active_fields = fields_config.split(',').collect(:strip).collect(:to_sym)
      [:group, :website_url, :page_path].each do |field|
        Radiant::Config[key(field)] = true if active_fields.include?(field)
      end
      fields.destroy
    end
  end
private
  def self.key(field)
    "locations.use_#{field.to_s.pluralize}?"
  end
end
