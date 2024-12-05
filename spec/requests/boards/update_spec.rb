require 'rails_helper'

RSpec.describe "PUT /boards/:id", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }

  before { sign_in user }

  it "succeed" do
    put board_path(board), params: {
      board: {
        name: "test"
      }
    }

    expect(response).to have_http_status(:redirect)
  end
end
