Spree::ProductsController.class_eval do
  
  def index_with_filter
    index_without_filter
    filterables = %w"baseball_cap_color" # todo: this shouldnt be here
    filter_on = filterables.select { |key| params.has_key? key }
    filter_on.each do |filterable|
      # todo: use here the faster Person.where("data @> 'foo=>bar'") syntax
      @products = @products.where("data -> ? = ?", filterable, params[filterable])
    end
  end

  alias_method :index_without_filter, :index
  alias_method :index, :index_with_filter
end