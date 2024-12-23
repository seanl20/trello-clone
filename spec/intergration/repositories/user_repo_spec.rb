require "rails_helper"

RSpec.describe Repositories::UserRepo do
  describe "#get_all" do
    subject(:get_all) { described_class.new.get_all }

    context "when there are mutliple users" do
      let!(:user_1) { FactoryBot.create(:user) }
      let!(:user_2) { FactoryBot.create(:user) }
      let!(:user_3) { FactoryBot.create(:user) }

      it "return all users" do
        expect(get_all).to match_unordered_elements(user_1, user_2, user_3)
      end
    end

    context "when there are no users" do
      it "return empty" do
        expect(get_all).to be_empty
      end
    end
  end
end
