module HStoreFilter
  class Filter
    attr_accessor :property

    def initialize property, product_collection
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

  class FilterOption
    attr_accessor :value, :property

    def initialize value, property, product_collection
      @value = value
      @property = property
      @product_collection = product_collection
    end

    def number_of_products
      hstore_filter = ActiveRecord::Base::sanitize "#{@property.name}=>\"#{@value}\""
      filter = "data @> #{hstore_filter}::hstore"
      @number_of_products ||= @product_collection
                                  .limit(nil)
                                  .where(filter)
                                  .count
    end
  end

  class FilterScope
    def initialize params, filterables, product_collection
      @params = params
      @filterables = filterables
      @product_collection = product_collection
    end

    def filter
      filters = []
      @filterables.each do |filterable|
        filters_per_filterable = []
        property = filterable.property
        @params[property.name].each do |value|
          hstore_filter = ActiveRecord::Base::sanitize "#{property.name}=>\"#{value}\""
          filters_per_filterable << "data @> #{hstore_filter}::hstore"
        end

        filters << filters_per_filterable.join(' OR ') 
      end
      
      filter = filters.join(') AND (')
      filters.empty? ? @product_collection : @product_collection.where("(#{filter})")
    end
  end
end

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
      params.has_key?(property.name) and params[property.name].present?
    end
  end

  def filters
    @taxon.properties.map do |property|
      ::HStoreFilter::Filter.new property, @products
    end
  end
end