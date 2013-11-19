Spree::ProductProperty.class_eval do
  after_save :update_data_hstore

  private
  def update_data_hstore
    data = {}
    product.properties.each do |property|
      data[property.name.to_sym] = product.property(property.name)
    end
    product.data = data
    product.save!
  end
end