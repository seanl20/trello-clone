# frozen_string_literal: true

module Boards
  module Commands
    class Delete < Command
      def call(id:)
        board = yield delete_board(id:)

        Success(board:)
      end

      def delete_board(id:)
        Success(Repositories::BoardRepo.new.delete(id:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
