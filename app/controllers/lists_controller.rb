class ListsController < ApplicationController
  before_action :authenticate_user!

  def new
    @list = board.lists.new
  end

  private

  def board
    @board ||= Boards::Queries::Get.new.call(id: params[:board_id])
  end
end
