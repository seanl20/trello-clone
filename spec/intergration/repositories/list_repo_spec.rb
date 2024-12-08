require "rails_helper"

RSpec.describe Repositories::ListRepo do
  describe "#get_by_board" do
    subject(:get_by_board) { described_class.new.get_by_board(board:) }

    let!(:user) { FactoryBot.create(:user) }

    let!(:board_1) { FactoryBot.create(:board, user:) }
    let!(:board_2) { FactoryBot.create(:board, user:) }
    let!(:board_3) { FactoryBot.create(:board, user:) }

    let!(:list_1) { FactoryBot.create(:list, board: board_1) }
    let!(:list_2) { FactoryBot.create(:list, board: board_1) }
    let!(:list_3) { FactoryBot.create(:list, board: board_2) }


    context "board have properties" do
      let!(:board) { board_1 }

      it "returns board's properties" do
        expect(get_by_board).to match_unordered_elements(list_1, list_2)
        expect(get_by_board).to_not include(list_3)
      end
    end

    context "board does not have properties" do
      let!(:board) { board_3 }

      it "returns board's properties" do
        expect(get_by_board).to be_empty
      end
    end
  end
end
