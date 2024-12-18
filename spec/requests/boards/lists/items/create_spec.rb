require 'rails_helper'

RSpec.describe "POST /boards/:board_id/lists/:list_id/items", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }
  let!(:list) { FactoryBot.create(:list, board:) }

  before { sign_in user }

  it "succeed" do
    post board_list_items_path(board, list), params: {
      item: {
        title: "test",
        description: "test description"
      }
    }

    expect(response).to have_http_status(:redirect)
  end
end
