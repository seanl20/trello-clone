class ItemMembersController < ApplicationController
  before_action :authenticate_user!

  def new
    list
    @item_member, @users = ItemMembers::Queries::NewItemMember.new.call(board:, item:)
  end

  def create
    ItemMembers::Commands::UpdateMembers.new.call(id: params[:item_id], params: item_member_params)

    redirect_to board_path(board)
  end

  private

  def item_member_params
    params.permit(user_ids: [])
  end

  def board
    @board ||= Boards::Queries::Get.new.call(id: params[:board_id])
  end

  def list
    @list ||= Lists::Queries::Get.new.call(id: params[:list_id], board:)
  end

  def item
    @item ||= Items::Queries::Get.new.call(item_id: params[:item_id])
  end
end
