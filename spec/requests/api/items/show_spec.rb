require 'rails_helper'

RSpec.describe "GET /api/items/:id", type: :request do
  def json
    JSON.parse(response.body)
  end

  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }
  let!(:list) { FactoryBot.create(:list, board:) }
  let!(:item) { FactoryBot.create(:item, list:) }

  before { sign_in user }

  it "succeed" do
    get api_item_path(item)

    expect(response).to have_http_status(:success)
    expect(json.dig("data", "attributes", "title")).to eq(item.title)
    expect(json.dig("data", "attributes", "description")).to eq(item.description)
  end
end
