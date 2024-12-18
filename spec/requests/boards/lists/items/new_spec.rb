require 'rails_helper'

RSpec.describe "GET /boards/:board_id/lists/:list_id/items/new", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }
  let!(:list) { FactoryBot.create(:list, board:) }

  before { sign_in user }

  it "succeed" do
    get new_board_list_item_path(board, list)

    expect(response).to have_http_status(:success)
  end
end
