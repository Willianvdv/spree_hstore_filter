require 'spec_helper'

describe Spree::ProductsController do
  let!(:product_with_the_blue_cap) { 
    product_property = FactoryGirl.create :product_property 
    product_property.value = 'blue'
    product_property.save!
    product_property.product
  }

  let!(:product_with_the_red_cap) { 
    product_property = FactoryGirl.create :product_property 
    product_property.value = 'red'
    product_property.save!
    product_property.product
  }

  it 'should filter on the data params' do
    spree_get :index, baseball_cap_color: 'blue'
    expect(assigns[:products]).to eq([product_with_the_blue_cap])
  end

  it 'should not filter if no params are given' do
    spree_get :index
    expect(assigns[:products]).to eq([product_with_the_red_cap, product_with_the_blue_cap])
  end

end