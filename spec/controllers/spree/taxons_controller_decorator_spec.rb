require 'spec_helper'

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
    it 'filters on the data params' do
      spree_get :show, :id => taxon.permalink, baseball_cap_color: ['blue', 'yellow']
      expect(assigns[:products]).to eq([product_with_the_blue_cap])
    end
    
    context 'no filters are given' do
      it 'returns all the products' do
        spree_get :show, :id => taxon.permalink
        expect(assigns[:products]).to match_array([product_with_the_blue_cap, product_with_the_red_cap])
      end
    end

    context 'multiple filters' do
      let!(:size_property) { FactoryGirl.create :property, name: 'size', presentation: 'size' }

      before :each do
        Spree::TaxonFilter.create taxon: taxon, property: size_property
      end

      it 'not returns products that dont match second filter' do
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