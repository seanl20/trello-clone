require 'rails_helper'

RSpec.describe "GET /boards/:id/edit", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }
  let!(:list) { FactoryBot.create(:list, board:) }

  before { sign_in user }

  it "succeed" do
    get edit_board_list_path(board, list)

    expect(response).to have_http_status(:success)
  end
end
