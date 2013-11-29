module Spree
  class TaxonFilter < ActiveRecord::Base
    belongs_to :taxon
    belongs_to :property
  end
end