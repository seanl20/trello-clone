module Api
  class ListPositionsController < ApplicationController
    protect_from_forgery with: :null_session, only: :update

    def update
      @lists = Lists::Commands::UpdatePosition.new.call(id: params[:id], board_id: params[:board_id], position: params[:position])

      render json: ListSerializer.new(@lists).serializable_hash.to_json
    end
  end
end
