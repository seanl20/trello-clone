require "rails_helper"

RSpec.describe Repositories::BoardRepo do
  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }

    let!(:user) { FactoryBot.create(:user) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          name: "test",
          user:
        }
      end

      it "create board" do
        expect { create }.to change { Board.count }.by(1)
      end
    end

    context "when invalid attrs are passed" do
      let(:attrs) do
        {
          user:
        }
      end

      it "does not create board" do
        expect { create }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#get" do
    subject(:get) { described_class.new.get(id:) }

    let!(:user) { FactoryBot.create(:user) }

    let!(:board) { FactoryBot.create(:board, user:) }

    context "board exists" do
      let!(:id) { board.id }

      it "returns board" do
        expect(get).to eq(board)
      end
    end

    context "board does not exists" do
      let!(:id) { "test" }

      it "returns not found error" do
        expect { get }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#get_by_user" do
    subject(:get_by_user) { described_class.new.get_by_user(user:) }

    let!(:user_1) { FactoryBot.create(:user) }
    let!(:user_2) { FactoryBot.create(:user) }
    let!(:user_3) { FactoryBot.create(:user) }

    let!(:board_1) { FactoryBot.create(:board, user: user_1) }
    let!(:board_2) { FactoryBot.create(:board, user: user_1) }
    let!(:board_3) { FactoryBot.create(:board, user: user_2) }

    context "user have properties" do
      let!(:user) { user_1 }

      it "returns user's properties" do
        expect(get_by_user).to match_unordered_elements(board_1, board_2)
        expect(get_by_user).to_not include(board_3)
      end
    end

    context "user does not have properties" do
      let!(:user) { user_3 }

      it "returns user's properties" do
        expect(get_by_user).to be_empty
      end
    end
  end

  describe "#update" do
    subject(:update) { described_class.new.update(id: board_id, attrs:) }

    context "board exists" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:board) { FactoryBot.create(:board, user:) }

      let(:board_id) { board.id }
      let(:attrs) do
        {
          name: "Test"
        }
      end

      it "is successful" do
        expect(update).to be true

        reloaded_board = board.reload
        expect(reloaded_board.name).to eq("Test")
      end
    end

    context "board does not exists" do
      let(:board_id) { "test" }
      let(:attrs) do
        {}
      end

      it "is not found" do
        expect { update }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#delete" do
    subject(:delete) { described_class.new.delete(id: board_id) }

    context "board exists" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:board) { FactoryBot.create(:board, user:) }

      let(:board_id) { board.id }

      it "delete board" do
        expect { delete }.to change { Board.count }.by(-1)
      end
    end

    context "board does not exists" do
      let(:board_id) { "test" }

      it "is not found" do
        expect { delete }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#update_members" do
    subject(:update_members) { described_class.new.update_members(id: board_id, user_ids:) }

    context "board exists" do
      context "Adding new members" do
        let!(:user_1) { FactoryBot.create(:user) }
        let!(:user_2) { FactoryBot.create(:user) }
        let!(:user_3) { FactoryBot.create(:user) }
        let!(:board) { FactoryBot.create(:board, user: user_1) }

        let(:board_id) { board.id }
        let(:user_ids) { [ user_2.id, user_3.id ] }

        it "update_members board" do
          update_members

          expect(board.reload.members).to match_unordered_elements(user_1, user_2, user_3)
        end
      end

      context "removing old members" do
        let!(:user_1) { FactoryBot.create(:user) }
        let!(:user_2) { FactoryBot.create(:user) }
        let!(:user_3) { FactoryBot.create(:user) }
        let!(:board) { FactoryBot.create(:board, user: user_1) }
        let!(:board_user_1) { FactoryBot.create(:board_user, board:, user: user_2) }
        let!(:board_user_2) { FactoryBot.create(:board_user, board:, user: user_3) }

        let(:board_id) { board.id }
        let(:user_ids) { [] }

        it "update_members board" do
          update_members

          expect(board.reload.members).to match_unordered_elements(user_1)
        end
      end
    end

    context "board does not exists" do
      let(:board_id) { "test" }
      let(:user_ids) { [] }

      it "is not found" do
        expect { update_members }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
