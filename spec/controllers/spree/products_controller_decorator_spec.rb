require 'spec_helper'

describe Spree::ProductsController do
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


  describe '.filterables' do
    it 'should only return properties marked as filterable' do
      filterables = Spree::ProductsController.new.send(:filterables)
      expect(filterables).to eq([filterable_property.name,])
    end
  end

  describe '.index' do
    describe 'filter' do
      it 'should not filter if no filters are given' do
        spree_get :index
        expect(assigns[:products]).to eq([product_with_the_red_cap, product_with_the_blue_cap])
      end
      
      it 'should filter on the data params' do
        spree_get :index, baseball_cap_color: ['blue', 'yellow']
        expect(assigns[:products]).to eq([product_with_the_blue_cap])
      end

      it 'should not filter if no params are given' do
        spree_get :index
        expect(assigns[:products]).to eq([product_with_the_red_cap, product_with_the_blue_cap])
      end
    end
  end
end