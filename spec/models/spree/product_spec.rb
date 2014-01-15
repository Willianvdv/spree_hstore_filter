require 'spec_helper'

describe Spree::Product do
  context "data" do
    let(:product) { 
      product = FactoryGirl.create :product
      product.product_properties_attributes = [{:property_name=>"a", :value=>"b"}]
      product.save!
      product
    }
    
    it "creates a presistent data field containing products properties" do
      product.reload
      assert_equal({'a' => 'b'}, product.data)
    end
  end
end