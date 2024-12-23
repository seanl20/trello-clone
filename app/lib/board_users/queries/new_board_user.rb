# frozen_string_literal: true

module BoardUsers
  module Queries
    class NewBoardUser < Query
      def call(board:)
        users = Repositories::UserRepo.new.get_all
        board_user = board.board_users.new

        return board_user, users
      end
    end
  end
end
