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
    board
    list
    @item = Items::Queries::GetByList.new.call(item_id: params[:id], list:)
  end

  def update
    result = Items::Commands::Update.new.call(id: params[:id], params: item_params)

    case result
    in Success(:success)
      redirect_to root_path
    in Failure(:invalid)
      render :edit
    end
  end

  def destroy
    result = Items::Commands::Delete.new.call(id: params[:id])

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
