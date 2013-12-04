Spree::TaxonsController.class_eval do
  def show_with_filter
    show_without_filter

    filter_on = filterables.select { |filterable| params.has_key? filterable.name }
    filter_on.each do |filterable|
      if params[filterable.name]
        filter = params[filterable.name].map do |value| 
          value = ActiveRecord::Base::sanitize(value)
          "data -> '#{filterable.name}' = #{value}"
        end

        filter = filter.join(' OR ')
        @products = @products.where("#{filter}")
      end
    end
    @filterables_with_values = filterables_with_values
  end

  alias_method :show_without_filter, :show
  alias_method :show, :show_with_filter

  private
  def filterables
    @taxon.filterables
  end

  def filterables_with_values
    filterables.collect { |property|
      [property, product_values_for_product(property)]
    }
  end

  def product_values_for_product property
    @products.joins(:product_properties)
              .where('spree_product_properties.property_id = ?', property.id)
              .distinct('spree_product_properties.value')
              .limit(nil)
              .select('spree_product_properties.value')
              .pluck('spree_product_properties.value')
  end
end