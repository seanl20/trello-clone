class BoardsController < ApplicationController
  before_action :authenticate_user!

  def new
    @board = Board.new
  end

  def edit
    authorize board
  end

  def show
    authorize board
  end

  def create
    result = Boards::Commands::Create.new.call(params: board_params, user: current_user)

    case result
    in Success(:success)
      redirect_to root_path
    in Failure(:invalid)
      render :new
    end
  end

  def update
    authorize board
    result = Boards::Commands::Update.new.call(id: params[:id], params: board_params)

    case result
    in Success(:success)
      redirect_to root_path
    in Failure(:invalid)
      render :edit
    end
  end

  def destroy
    authorize board

    result = Boards::Commands::Delete.new.call(id: params[:id])

    case result
    in Success(:success)
      redirect_to root_path
    in Failure(:invalid)
      redirect_to root_path
    end
  end

  private

  def board_params
    params.require(:board).permit(:name)
  end

  def board
    @board ||= Boards::Queries::Get.new.call(id: params[:id])
  end
end
