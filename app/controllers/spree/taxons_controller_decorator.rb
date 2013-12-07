Spree::TaxonsController.class_eval do
  def show_with_filter
    show_without_filter

    filter_on = filterables.select { |filterable| params.has_key? filterable.name }
    filter_on.each do |filterable|
      # todo: use here the faster Person.where("data @> 'foo=>bar'") syntax
      @products = @products.where("data -> ? = ?", filterable.name, params[filterable.name])
    end
    @filterables_with_values = filterables_with_values
  end

  alias_method :show_without_filter, :show
  alias_method :show, :show_with_filter

  private
  def filterables
    @taxon.properties
  end

  def filterables_with_values
    filterables.collect { |property|
      [property, product_values_for_product(property)]
    }
  end

  def product_values_for_product property
    @products.joins(:product_properties)
              .where('spree_product_properties.property_id = ?', property.id)
              .select('spree_product_properties.value')
              .distinct('spree_product_properties.value')
              .limit(nil)
              .reorder(nil)
              .pluck('spree_product_properties.value')
  end
end