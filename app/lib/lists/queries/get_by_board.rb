# frozen_string_literal: true

module Lists
  module Queries
    class GetByBoard < Query
      def call(board_id:)
        board = Repositories::BoardRepo.new.get(id: board_id)
        Repositories::ListRepo.new.get_by_board(board:)
      end
    end
  end
end
