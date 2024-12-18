require 'rails_helper'

RSpec.describe "PUT /boards/:board_id/lists/:id", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }
  let!(:list) { FactoryBot.create(:list, board:) }

  before { sign_in user }

  it "succeed" do
    put board_list_path(board, list), params: {
      list: {
        title: "test"
      }
    }

    expect(response).to have_http_status(:redirect)
  end
end
