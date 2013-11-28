class CreateTaxonFilters < ActiveRecord::Migration
  def change
    create_table :spree_taxon_filters do |t|
      t.references :taxon, index: true
      t.references :property, index: true

      t.timestamps
    end
  end
end
