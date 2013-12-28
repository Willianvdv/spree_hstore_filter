require 'spec_helper'

describe 'filter a taxon by product properties' do
  include_context "filterable properties"

  before :each do
    taxon.products.push product_with_the_blue_cap, product_with_the_red_cap
    taxon.save!
  end

  it 'can see the filters on the properties page' do
    visit "/t/#{taxon.permalink}"

    puts page.body
    
    within('#sidebar') do
      page.should have_content("cap color")
    end
  end
end