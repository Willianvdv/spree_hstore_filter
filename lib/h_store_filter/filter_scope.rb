module HStoreFilter
  class FilterScope
    def initialize(params, filterables, product_collection)
      @params = params
      @filterables = filterables
      @product_collection = product_collection
    end

    def filter
      filters = []
      @filterables.each do |filterable|
        filters_per_filterable = []
        property = filterable.property

        values = @params[property.name]
        values = [values] unless values.is_a? Array

        values.each do |value|
          hstore_filter = ActiveRecord::Base.sanitize "\"#{property.name}\"=>\"#{value}\""
          filters_per_filterable << "data @> #{hstore_filter}::hstore"
        end

        filters << filters_per_filterable.join(' OR ')
      end

      filter = filters.join(') AND (')
      filters.empty? ? @product_collection : @product_collection.where("(#{filter})")
    end
  end
end
