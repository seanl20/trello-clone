# frozen_string_literal: true

module Boards
  module Commands
    class Update < Command
      def call(id:, params:)
        yield update_board(id:, attrs: Boards::Changesets::Update.map(params))

        Success(board: board_repo.get(id:))
      end

      def update_board(id:, attrs:)
        Success(board_repo.update(id:, attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end

      private

      def board_repo
        Repositories::BoardRepo.new
      end
    end
  end
end
