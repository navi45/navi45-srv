require 'rails_helper'

RSpec.describe "api/v1s/show", :type => :view do
  before(:each) do
    @api_v1 = assign(:api_v1, Api::V1::Event.create!(
      :title => "Title",
      :desc => "MyText",
      :location => "Location",
      :url => "MyText",
      :image-url => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
