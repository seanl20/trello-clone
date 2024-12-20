# frozen_string_literal: true

module Boards
  module Commands
    class Update < Command
      def call(id:, params:)
        yield update_board(id:, attrs: Boards::Changesets::Update.map(params))

        Success(:success)
      end

      def update_board(id:, attrs:)
        Success(Repositories::BoardRepo.new.update(id:, attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
