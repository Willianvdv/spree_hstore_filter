require 'spec_helper'

describe Spree::TaxonsController do
  let!(:product_property_with_the_blue_cap) { 
    product_property = FactoryGirl.create :product_property 
    product_property.value = 'blue'
    product_property.save!
    product_property
  }

  let!(:product_with_the_blue_cap) { 
    product_property_with_the_blue_cap.product
  }

  let!(:filterable_property) {
    property = product_property_with_the_blue_cap.property
    property.filterable = true
    property.save!
    property
  }

  let!(:product_with_the_red_cap) { 
    product_property = FactoryGirl.create :product_property 
    product_property.value = 'red'
    product_property.save!
    product_property.product
  }

  let!(:taxon) { FactoryGirl.create :taxon }
  let!(:taxonfilter) { Spree::TaxonFilter.create(taxon: taxon, property: filterable_property)}

  before :each do
    taxon.products.push product_with_the_blue_cap
    taxon.save!
  end
  
  describe '.show' do
    it 'assigns the filterable_properties' do
      spree_get :show, :id => taxon.permalink
      expect(assigns[:filterables_with_values]).to eq([[filterable_property, ['blue']]])
    end
  end
end