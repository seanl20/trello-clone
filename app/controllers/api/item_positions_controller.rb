module Api
  class ItemPositionsController < ApplicationController
    protect_from_forgery with: :null_session

    def update
      @items = Items::Commands::UpdatePosition.new.call(items_data: items_params[:items])

      render json: ItemSerializer.new(@items).serializable_hash.to_json
    end

    private

    def items_params
      params.permit(items: [ :id, :position, :list_id ])
    end
  end
end
