require "spec_helper"

describe "external redirection" do

  it 'redirects /categories to home.' do
    get "/categories"
    response.should redirect_to( "/" )
  end

end
