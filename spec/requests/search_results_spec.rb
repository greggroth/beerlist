require 'spec_helper'

describe "Searching" do
  it " does a search" do
    bar = FactoryGirl.create(:bar)

    5.times do
      FactoryGirl.create(:bar)
      FactoryGirl.create(:beer)
      FactoryGirl.create(:brewery)
    end

    visit root_path
    fill_in "site_search_box", :with => bar.name
    click_button "Search"
    current_path.should eq(search_results_path) 
    page.should have_content bar.name
  end
end