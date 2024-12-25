require 'rails_helper'

RSpec.describe "GET /boards/:board_id/lists/:list_id/items/:item_id/item_members/new", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }
  let!(:list) { FactoryBot.create(:list, board:) }
  let!(:item) { FactoryBot.create(:item, list:) }

  before { sign_in user }

  it "succeed" do
    get new_board_list_item_item_member_path(board, list, item)

    expect(response).to have_http_status(:success)
  end
end
