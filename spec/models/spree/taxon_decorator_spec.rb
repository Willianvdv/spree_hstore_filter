require 'spec_helper'

describe Spree::Taxon do
  let(:taxon) { FactoryGirl.create :taxon }
  let(:property) { FactoryGirl.create :property }

  before :each do
    @taxon_filter = Spree::TaxonFilter.create!(taxon: taxon, property: property)
  end

  it 'has taxon filters' do
    expect(taxon.taxon_filters).to eq([@taxon_filter])
  end

  describe '.filterables' do
    it 'returns the properties defined as filterable' do
      expect(taxon.filterables).to eq([property])
    end
  end
end