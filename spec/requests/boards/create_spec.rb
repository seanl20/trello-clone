require 'rails_helper'

RSpec.describe "POST /boards", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in user }

  it "succeed" do
    post boards_path, params: {
      board: {
        name: "test"
      }
    }

    expect(response).to have_http_status(:redirect)
  end
end
