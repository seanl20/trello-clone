require "rails_helper"

RSpec.describe Repositories::ListRepo do
  describe "#get_by_board" do
    subject(:get_by_board) { described_class.new.get_by_board(board:) }

    let!(:user) { FactoryBot.create(:user) }

    let!(:board_1) { FactoryBot.create(:board, user:) }
    let!(:board_2) { FactoryBot.create(:board, user:) }
    let!(:board_3) { FactoryBot.create(:board, user:) }

    let!(:list_1) { FactoryBot.create(:list, board: board_1, position: 0) }
    let!(:list_2) { FactoryBot.create(:list, board: board_1, position: 1) }
    let!(:list_3) { FactoryBot.create(:list, board: board_2) }


    context "board have properties" do
      let!(:board) { board_1 }

      it "returns board's properties" do
        expect(get_by_board).to match_ordered_elements(list_1, list_2)
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

  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }

    let!(:user) { FactoryBot.create(:user) }

    let!(:board) { FactoryBot.create(:board, user:) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          title: "test",
          board:
        }
      end

      it "create list" do
        expect { create }.to change { List.count }.by(1)
      end
    end

    context "when invalid attrs are passed" do
      let(:attrs) do
        {
          board:
        }
      end

      it "does not create list" do
        expect { create }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#get" do
    subject(:get) { described_class.new.get(id:, board:) }

    let!(:user) { FactoryBot.create(:user) }

    let!(:board_1) { FactoryBot.create(:board, user:) }
    let!(:board_2) { FactoryBot.create(:board, user:) }

    let!(:list_1) { FactoryBot.create(:list, board: board_1) }
    let!(:list_2) { FactoryBot.create(:list, board: board_1) }

    context "correct list id and board passed" do
      let!(:board) { board_1 }
      let!(:id) { list_1.id }

      it "returns user's properties" do
        expect(get).to eq(list_1)
      end
    end

    context "correct list id and incorrect board passed" do
      let!(:board) { board_2 }
      let!(:id) { list_1.id }

      it "returns user's properties" do
        expect { get }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "incorrect id pass" do
      let!(:board) { board_1 }
      let!(:id) { "test" }

      it "returns user's properties" do
        expect { get }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#update" do
    subject(:update) { described_class.new.update(id: list_id, attrs:) }

    context "list exists" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:board) { FactoryBot.create(:board, user:) }
      let!(:list) { FactoryBot.create(:list, board:) }

      let(:list_id) { list.id }
      let(:attrs) do
        {
          title: "Test"
        }
      end

      it "is successful" do
        expect(update).to be true

        reloaded_list = list.reload
        expect(reloaded_list.title).to eq("Test")
      end
    end

    context "list does not exists" do
      let(:list_id) { "test" }
      let(:attrs) do
        {}
      end

      it "is not found" do
        expect { update }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#delete" do
    subject(:delete) { described_class.new.delete(id: list_id) }

    context "list exists" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:board) { FactoryBot.create(:board, user:) }
      let!(:list) { FactoryBot.create(:list, board:) }

      let(:list_id) { list.id }

      it "delete list" do
        expect { delete }.to change { List.count }.by(-1)
      end
    end

    context "list does not exists" do
      let(:list_id) { "test" }

      it "is not found" do
        expect { delete }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
