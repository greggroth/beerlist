require 'spec_helper'

describe SearchResultsController do

  it " finds a bar" do
    bar = FactoryGirl.create(:bar)
    
    get 'index', q: bar.name
    
    response.should be_success
  end

end
