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

  describe "#get_all" do
    subject(:get_all) { described_class.new.get_all(ids:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:board) { FactoryBot.create(:board, user:) }
    let!(:list) { FactoryBot.create(:list, board:) }
    let!(:item_1) { FactoryBot.create(:item, list:) }
    let!(:item_2) { FactoryBot.create(:item, list:) }
    let!(:item_3) { FactoryBot.create(:item, list:) }

    context "when valid ids are passed" do
      let(:ids) do
        [ item_1.id, item_2.id, item_3.id ]
      end

      it "get all items" do
        expect(get_all).to match_ordered_elements(item_1, item_2, item_3)
      end
    end

    context "when empty ids are passed" do
      let(:ids) do
        []
      end

      it "does not create item" do
        expect(get_all).to be_empty
      end
    end
  end

  describe "#import_update_all" do
    subject(:import_update_all) { described_class.new.import_update_all(items_data:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:board) { FactoryBot.create(:board, user:) }
    let!(:list_1) { FactoryBot.create(:list, board:) }
    let!(:list_2) { FactoryBot.create(:list, board:) }
    let!(:item_1) { FactoryBot.create(:item, list: list_1) }
    let!(:item_2) { FactoryBot.create(:item, list: list_1) }
    let!(:item_3) { FactoryBot.create(:item, list: list_1) }

    context "when valid ids are passed" do
      let(:items_data) do
        [ {
          id: item_1.id,
          position: 0,
          list_id: list_1.id
        }, {
          id: item_2.id,
          position: 1,
          list_id: list_1.id
        }, {
          id: item_3.id,
          position: 0,
          list_id: list_2.id
        } ]
      end

      it "import update all" do
        import_update_all

        expect(item_3.reload.list).to eq(list_2)
      end
    end
  end
end
