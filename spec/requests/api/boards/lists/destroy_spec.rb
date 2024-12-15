require 'rails_helper'

RSpec.describe "DELETE /boards/:id", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }
  let!(:list) { FactoryBot.create(:list, board:) }

  before { sign_in user }

  it "succeed" do
    delete board_list_path(board, list), headers: { 'ACCEPT': 'application/json' }

    expect(response).to have_http_status(:success)
  end
end
