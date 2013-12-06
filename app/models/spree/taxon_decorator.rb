Spree::Taxon.class_eval do
  has_many :taxon_filters
  has_many :properties, through: :taxon_filters

  # todo: remove this method
  def filterables
    properties
  end
end