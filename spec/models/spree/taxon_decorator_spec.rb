require 'spec_helper'

describe Spree::Taxon do
  let(:taxon) { FactoryGirl.create :taxon }
  let(:property) { FactoryGirl.create :property }
  let(:property2) { FactoryGirl.create :property }


  describe 'no taxon filters are defined' do
    it 'creates taxon filters' do
      taxon.property_ids = [property.id, property2.id]
      expect(taxon.properties).to eq([property, property2])
    end
  end

  describe 'has taxon filters defined' do
    before :each do
      @taxon_filter = Spree::TaxonFilter.create!(taxon: taxon, property: property)
    end

    it 'has taxon filters' do
      expect(taxon.taxon_filters).to eq([@taxon_filter])
    end

    describe '#properties' do
      it 'returns the properties' do
        expect(taxon.properties).to eq([property])
      end
    end

    describe '.filterables' do
      it 'returns the properties defined as filterable' do
        expect(taxon.filterables).to eq([property])
      end
    end
  end
end