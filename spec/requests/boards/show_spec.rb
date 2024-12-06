require 'rails_helper'

RSpec.describe "GET /boards/:id", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }

  before { sign_in user }

  it "succeed" do
    get board_path(board)

    expect(response).to have_http_status(:success)
  end
end
