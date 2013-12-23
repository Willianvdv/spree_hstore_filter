require 'spec_helper'

shared_context "filterable properties" do
  let!(:product_property_with_the_blue_cap) { 
    product_property = FactoryGirl.create :product_property 
    product_property.value = 'blue'
    product_property.save!
    product_property
  }
  let!(:filterable_property) { product_property_with_the_blue_cap.property }
  let!(:product_with_the_blue_cap) { product_property_with_the_blue_cap.product }
  let!(:product_with_the_red_cap) { 
    product_property = FactoryGirl.create :product_property 
    product_property.value = 'red'
    product_property.save!
    product_property.product
  }
  let!(:taxon) { FactoryGirl.create :taxon }
  
  before :each do
    Spree::TaxonFilter.create taxon: taxon, property: filterable_property
  end
end

describe HStoreFilter::Filter do
  include_context "filterable properties"

  subject { HStoreFilter::Filter.new filterable_property, Spree::Product }

  describe '.values' do
    it 'returns the values of the property in the products scope' do
      expect(subject.values).to eq(['blue'])
    end
  end

  describe '.options' do
    it 'creates a filter option for each value' do
      HStoreFilter::FilterOption.should_receive(:new).with('blue', 
                                                      filterable_property, 
                                                      Spree::Product)
      expect(subject.options.length).to eq(1)
    end
  end
end

describe HStoreFilter::FilterOption do
  include_context "filterable properties"

  subject { HStoreFilter::FilterOption.new 'blue', filterable_property, Spree::Product }

  describe '.number_of_products' do
    it 'return the number of products when filtered on this option' do
      expect(subject.number_of_products).to eq(1)
    end

    context 'has a value no product has' do
      subject { HStoreFilter::FilterOption.new 'pink', filterable_property, Spree::Product }

      it 'returns 0' do
        expect(subject.number_of_products).to eq(0)
      end
    end
  end
end

describe Spree::TaxonsController do
  include_context "filterable properties"

  before :each do
    taxon.products.push product_with_the_blue_cap, product_with_the_red_cap
    taxon.save!
  end
  
  describe '.show' do
    it 'should filter on the data params' do
      spree_get :show, :id => taxon.permalink, baseball_cap_color: ['blue', 'yellow']
      expect(assigns[:products]).to eq([product_with_the_blue_cap])
    end

    context 'multiple filters' do
      let!(:size_property) { FactoryGirl.create :property, name: 'size', presentation: 'size' }

      before :each do
        Spree::TaxonFilter.create taxon: taxon, property: size_property
      end

      it 'should not return product if the second filter doesnt allow results' do
        spree_get :show, 
                  id: taxon.permalink, 
                  baseball_cap_color: ['blue',],
                  size: ['M',]
        expect(assigns[:products]).to eq([])  
      end
    end
    
    it 'assigns the filters' do
      spree_get :show, :id => taxon.permalink
      expect(assigns[:filters])# .to eq([[filterable_property, ['blue']]])
    end
  end
end