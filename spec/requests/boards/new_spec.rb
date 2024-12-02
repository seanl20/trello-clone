require 'rails_helper'

RSpec.describe "GET /boards/new", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in user }

  it "succeed" do
    get new_board_path

    expect(response).to have_http_status(:success)
  end
end
