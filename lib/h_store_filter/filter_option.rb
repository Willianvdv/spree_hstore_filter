module HStoreFilter
  class FilterOption
    attr_accessor :value, :property

    def initialize(value, property, product_collection)
      @value = value
      @property = property
      @product_collection = product_collection
    end

    def number_of_products
      hstore_filter = ActiveRecord::Base.sanitize "\"#{@property.name}\"=>\"#{@value}\""
      filter = "data @> #{hstore_filter}::hstore"
      @number_of_products ||= @product_collection.limit(nil)
                                                 .where(filter)
                                                 .count
    end
  end
end
