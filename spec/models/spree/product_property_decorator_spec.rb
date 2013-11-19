require 'spec_helper'

describe Spree::ProductProperty do
  context "After save" do
    let(:product_property) { 
      product_property = FactoryGirl.create :product_property 
      product_property.value = 'blue'
      product_property
    }
    
    it "should update the product data hstore" do
      product_property.product.should_receive(:data=).with({baseball_cap_color: 'blue'})
      product_property.product.should_receive(:save!).once
      product_property.save!
    end
  end
end