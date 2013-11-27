Spree::ProductsController.class_eval do
  
  def index_with_filter
    index_without_filter
    filter_on = filterables.select { |key| params.has_key? key }
    filter_on.each do |filterable|
      # todo: use here the faster Person.where("data @> 'foo=>bar'") syntax
      @products = @products.where("data -> ? = ?", filterable, params[filterable])
    end
  end

  alias_method :index_without_filter, :index
  alias_method :index, :index_with_filter

  private
  def filterables
    Spree::Property.where(:filterable => true).pluck(:name)
  end
end