Spree::Product.class_eval do
  before_save :update_hstore_data_field

  private
  def update_hstore_data_field
    property_data = {}
    product_properties.each do |product_property|
      property_data[product_property.property.name] = product_property.value
    end
    self.data = property_data
  end
end