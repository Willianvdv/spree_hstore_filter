Spree::ProductProperty.class_eval do
  after_save :update_data_hstore

  private
  def update_data_hstore
    # todo: This method is called every time a productproperty is saved. 
    #       Refactor this so this method is called once per product save (when a product has multiple properties)
    
    product.data = Hash[(product.properties.map { |p| [p.name.to_sym, product.property(p.name)] })]
    product.save!
  end
end