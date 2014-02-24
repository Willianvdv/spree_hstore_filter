Spree::TaxonsController.class_eval do
  def show_with_filter
    show_without_filter
    filter_scope = HStoreFilter::FilterScope.new params, filter_on, @products

    @products = filter_scope.filter
    @filters = filters
  end

  alias_method :show_without_filter, :show
  alias_method :show, :show_with_filter

  private

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
