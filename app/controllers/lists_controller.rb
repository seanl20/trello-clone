class ListsController < ApplicationController
  before_action :authenticate_user!

  protect_from_forgery with: :null_session, only: :destroy

  def new
    @list = board.lists.new
  end

  def create
    result = Lists::Commands::Create.new.call(params: list_params, board:)

    case result
    in Success(:success)
      redirect_to root_path
    in Failure(:invalid)
      render :new
    end
  end

  def update
    result = Lists::Commands::Update.new.call(id: params[:id], params: list_params, board:)

    case result
    in Success(:success)
      redirect_to root_path
    in Failure(:invalid)
      render :edit
    end
  end

  def destroy
    result = Lists::Commands::Delete.new.call(id: params[:id])

    case result
    in Success(:success)
      respond_to do |format|
        format.json do
          render json: {}, status: 204
        end
      end
    in Failure(:invalid)
      respond_to do |format|
        format.json do
          render json: {}, status: 204
        end
      end
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
