require 'rails_helper'

RSpec.describe "DELETE /boards/:board_id/lists/:list_id/items/:id", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }
  let!(:list) { FactoryBot.create(:list, board:) }
  let!(:item) { FactoryBot.create(:item, list:) }

  before { sign_in user }

  it "succeed" do
    delete board_list_item_path(board, list, item), headers: { 'ACCEPT': 'application/json' }

    expect(response).to have_http_status(:success)
  end
end
