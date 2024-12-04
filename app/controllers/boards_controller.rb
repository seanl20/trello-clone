class BoardsController < ApplicationController
  before_action :authenticate_user!

  def new
    @board = Board.new
  end

  def edit
    # @board = Boards::Queries::Get.new.call(id: params[:id])
    @board = Board.find(params[:id])
    authorize @board
  end

  def create
    result = Boards::Commands::Create.new.call(params: board_params, user: current_user)

    case result
    in Success(board:)
      redirect_to root_path
    in Failure(:invalid)
      render :new
    end
  end

  private

  def board_params
    params.require(:board).permit(:name)
  end
end
