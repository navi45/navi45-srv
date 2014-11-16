require 'rails_helper'

RSpec.describe "api/v1s/index", :type => :view do
  before(:each) do
    assign(:api_v1_events, [
      Api::V1::Event.create!(
        :title => "Title",
        :desc => "MyText",
        :location => "Location",
        :url => "MyText",
        :image-url => "MyText"
      ),
      Api::V1::Event.create!(
        :title => "Title",
        :desc => "MyText",
        :location => "Location",
        :url => "MyText",
        :image-url => "MyText"
      )
    ])
  end

  it "renders a list of api/v1s" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
