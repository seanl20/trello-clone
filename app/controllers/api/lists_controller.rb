module Api
  class ListsController < ApplicationController
    def index
      @lists = Lists::Queries::GetByBoard.new.call(board_id: params[:board_id])

      render json: ListSerializer.new(@lists).serializable_hash.to_json
    end
  end
end
