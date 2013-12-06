module Spree
  class TaxonFilter < ActiveRecord::Base
    acts_as_list

    belongs_to :taxon
    belongs_to :property

    validates_uniqueness_of :taxon_id, :scope => :property_id, :message => :already_linked
  end
end