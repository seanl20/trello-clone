class ListsController < ApplicationController
  before_action :authenticate_user!

  def new
    @list = board.lists.new
  end

  def create
    result = Lists::Commands::Create.new.call(params: list_params, board:)

    case result
    in Success(list)
      redirect_to root_path
    in Failure(:invalid)
      render :new
    end
  end

  def edit
    @list = Lists::Queries::Get.new.call(id: params[:id], board:)
  end

  private

  def board
    @board ||= Boards::Queries::Get.new.call(id: params[:board_id])
  end

  def list_params
    params.require(:list).permit(:title)
  end
end
