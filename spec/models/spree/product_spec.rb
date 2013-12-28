require 'spec_helper'

describe Spree::Product do
  context "data" do
    let(:product) { 
      product = FactoryGirl.create :product 
      product.data = {'a' => 'b'}
      product.save!
      product
    }
    
    it "should be presistent" do
      product.reload
      assert_equal({'a' => 'b'}, product.data)
    end
  end
end