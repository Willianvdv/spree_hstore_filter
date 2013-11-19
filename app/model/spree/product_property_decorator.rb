Spree::ProductProperty.class_eval do
  after_save :update_data_hstore

  private
  def update_data_hstore
    product.data = {}
    product.save!
  end
end