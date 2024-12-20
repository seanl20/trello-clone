class ItemsController < ApplicationController
  before_action :authenticate_user!

  def new
    @item = list.items.new
  end

  def create
    result = Items::Commands::Create.new.call(params: item_params, list:)

    case result
    in Success(:success)
      redirect_to root_path
    in Failure(:invalid)
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def board
    @board ||= Boards::Queries::Get.new.call(id: params[:board_id])
  end

  def list
    @list ||= Repositories::ListRepo.new.get(id: params[:list_id], board:)
  end

  def item_params
    params.require(:item).permit(:title, :description)
  end
end
