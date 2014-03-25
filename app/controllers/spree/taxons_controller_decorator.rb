Spree::TaxonsController.class_eval do
  set_callback :show, :after, :filter_product_with_hstore
  set_callback :show, :after, :add_filters

  private

  def filter_product_with_hstore
    filter_scope = HStoreFilter::FilterScope.new params, filter_on, @products
    @products = filter_scope.filter
  end

  def add_filters
    @filters = filters
  end

  def filter_on
    filters.select do |filterable|
      property = filterable.property
      params.key?(property.name) && params[property.name].present?
    end
  end

  def filters
    @taxon.properties.map do |property|
      ::HStoreFilter::Filter.new property, @products
    end
  end
end
