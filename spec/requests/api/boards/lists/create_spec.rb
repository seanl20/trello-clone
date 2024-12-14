require 'rails_helper'

RSpec.describe "POST /boards", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }

  before { sign_in user }

  it "succeed" do
    post board_lists_path(board), params: {
      list: {
        title: "test"
      }
    }

    expect(response).to have_http_status(:redirect)
  end
end
