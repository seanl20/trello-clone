require 'rails_helper'

RSpec.describe Board, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many(:lists).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:board_users).dependent(:destroy) }
  it { is_expected.to have_many(:members).through(:board_users).source(:user) }

  describe "#assign_user_as_member" do
    let(:user) { FactoryBot.create(:user) }
    let!(:board) { FactoryBot.create(:board, user:) }

    it "assigns creator of board as one of the members" do
      expect(board.members).to include(user)
    end
  end
end
