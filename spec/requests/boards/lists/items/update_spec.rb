require 'rails_helper'

RSpec.describe "PUT /boards/:board_id/lists/:list_id/items/:id", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }
  let!(:list) { FactoryBot.create(:list, board:) }
  let!(:item) { FactoryBot.create(:item, list:) }

  before { sign_in user }

  it "succeed" do
    put board_list_item_path(board, list, item), params: {
      item: {
        title: "test",
        description: "description"
      }
    }

    expect(response).to have_http_status(:redirect)
  end
end
