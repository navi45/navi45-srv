require 'rails_helper'

RSpec.describe "Api::V1::Events", :type => :request do
  describe "GET /api_v1_events" do
    it "works! (now write some real specs)" do
      get api_v1_events_path
      expect(response.status).to be(200)
    end
  end
end
