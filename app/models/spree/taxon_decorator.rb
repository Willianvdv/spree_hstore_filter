Spree::Taxon.class_eval do
  has_many :taxon_filters

  def filterables
    taxon_filters.map(&:property)
  end
end