require 'spec_helper'

describe "Taxonomies and taxons" do
  stub_authorization!

  let!(:property1) { FactoryGirl.create :property }
  let!(:property2) { FactoryGirl.create :property }
  let!(:taxon) { FactoryGirl.create :taxon }

  it "admin should be able to edit taxon" do
    visit spree.edit_admin_taxonomy_taxon_path(taxon.taxonomy, taxon.id)
    fill_in "taxon_property_ids", :with => "#{property1.id},#{property2.id}"
    click_button "Update"

    visit spree.edit_admin_taxonomy_taxon_path(taxon.taxonomy, taxon.id)
    find_field('taxon_property_ids').value.should eq "#{property1.id},#{property2.id}"
  end
end