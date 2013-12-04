Spree::ProductsController.class_eval do
    def index_with_filter
    index_without_filter
    filter_on = filterables.select { |key| params.has_key? key }
    filter_on.each do |filterable|
      # todo: use here the faster Person.where("data @> 'foo=>bar'") syntax
      if filter = params[filterable]
        filter = params[filterable].map do |value| 
          value = ActiveRecord::Base::sanitize(value)
          "data -> '#{filterable}' = #{value}"
        end

        filter = filter.join(' OR ')
        @products = @products.where("#{filter}")
      end
    end
  end

  alias_method :index_without_filter, :index
  alias_method :index, :index_with_filter

  private
  def filterables
    Spree::Property.where(:filterable => true).pluck(:name)
  end
end