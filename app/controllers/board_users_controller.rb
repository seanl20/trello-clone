class BoardUsersController < ApplicationController
  before_action :authenticate_user!

  def new
    @board_user, @users = BoardUsers::Queries::NewBoardUser.new.call(board:)
  end

  def edit
    authorize board
  end

  def create
    BoardUsers::Commands::UpdateMembers.new.call(id: params[:board_id], params: board_user_params)

    redirect_to board_path(board)
  end

  private

  def board_user_params
    params.require(:board_user).permit(user_ids: [])
  end

  def board
    @board ||= Boards::Queries::Get.new.call(id: params[:board_id])
  end
end
