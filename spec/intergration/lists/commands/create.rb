require "rails_helper"

RSpec.describe Lists::Commands::Create, "#call", :db do
  let(:command) { described_class.new }

  let!(:user) { FactoryBot.create(:user) }

  let!(:board) { FactoryBot.create(:board, user:) }

  let!(:list_1) { FactoryBot.create(:list, board:) }
  let!(:list_2) { FactoryBot.create(:list, board:) }
  let!(:list_3) { FactoryBot.create(:list, board:) }

  subject(:call) do
    command.call(params:, board:)
  end

  let(:params) do
    {
      title: "TEST"
    }
  end

  it "returns ordered lists" do
    list_4 = call.success[:list]
    lists = Repositories::ListRepo.new.get_by_board(board:)

    expect(lists).to match_ordered_elements(list_1, list_2, list_3, list_4)
  end
end
