module HStoreFilter
  class Filter
    attr_accessor :property

    def initialize(property, product_collection)
      @property = property
      @product_collection = product_collection
    end

    def options
      values.map do |value|
        FilterOption.new value, @property, @product_collection
      end
    end

    def values
      @values ||= @product_collection
        .joins(:product_properties)
        .where('spree_product_properties.property_id = ?', @property.id)
        .select('spree_product_properties.value')
        .distinct('spree_product_properties.value')
        .limit(nil)
        .reorder(nil)
        .pluck('spree_product_properties.value')
    end
  end
end