require 'spec_helper'

describe 'filter a taxon by product properties' do
  include_context "filterable properties"

  before :each do
    taxon.products.push product_with_the_blue_cap, product_with_the_red_cap
    taxon.save!
  end

  subject! { visit "/t/#{taxon.permalink}" }

  it 'displays the property filter on the taxon page' do
    within('#sidebar') do
      page.should have_content("cap color")
    end
  end

  it 'displays all the property options on the taxon page' do
    within('.taxonfilter') do
      page.should have_content("blue")
      page.should have_content("red")
    end
  end

  it 'displays the number of products of the property value' do
    within('.checkbox-label[for="blue"]') do
      page.should have_content("(1)")
    end
    within('.checkbox-label[for="red"]') do
      page.should have_content("(1)")
    end
  end 

  context 'product are paginated' do
    it 'filters should ignore pagination' do
      Spree::Config.products_per_page = 1
      visit "/t/#{taxon.permalink}" 

      within('.checkbox-label[for="blue"]') do
        page.should have_content("(1)")
      end
      within('.checkbox-label[for="red"]') do
        page.should have_content("(1)")
      end
      Spree::Config.products_per_page = 25
    end

    # Regression test for issue 5
    context 'on the second page' do
      it 'filters should ignore pagination' do
        Spree::Config.products_per_page = 1
        visit "/t/#{taxon.permalink}?page=2" 

        within('.checkbox-label[for="blue"]') do
          page.should have_content("(1)")
        end
        within('.checkbox-label[for="red"]') do
          page.should have_content("(1)")
        end
      end
    end
  end
end