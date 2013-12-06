class AddPositionTaxonFilter < ActiveRecord::Migration
  def change
    add_column :spree_taxon_filters, :position, :integer
  end
end
