require "rails_helper"

RSpec.describe Repositories::ItemRepo do
  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:board) { FactoryBot.create(:board, user:) }
    let!(:list) { FactoryBot.create(:list, board:, position: 0) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          title: "test",
          list:
        }
      end

      it "create item" do
        expect { create }.to change { Item.count }.by(1)
      end
    end

    context "when invalid attrs are passed" do
      let(:attrs) do
        {
          list:
        }
      end

      it "does not create item" do
        expect { create }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
