require "rails_helper"

RSpec.describe Lists::Commands::UpdatePosition, "#call", :db do
  let(:command) { described_class.new }

  let!(:user) { FactoryBot.create(:user) }

  let!(:board) { FactoryBot.create(:board, user:) }

  let!(:list_1) { FactoryBot.create(:list, board:, position: 0) }
  let!(:list_2) { FactoryBot.create(:list, board:, position: 1) }
  let!(:list_3) { FactoryBot.create(:list, board:, position: 2) }

  subject(:call) do
    command.call(id:, board_id:, position:)
  end

  context "when board does exists" do
    let(:id) { list_1.id }
    let(:board_id) { board.id }
    let(:position) { 1 }

    it "returns ordered lists" do
      expect(call).to match_ordered_elements(list_2, list_1, list_3)
    end
  end

  context "when board does not exists" do
    let(:id) { list_1.id }
    let(:board_id) { "test" }
    let(:position) { 1 }

    it "returns not found error" do
      expect { call }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
