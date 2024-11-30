require 'rails_helper'

RSpec.describe "GET /index", type: :request do
  it "succeeds" do
    get root_path

    expect(response).to be_successful
  end
end
