# frozen_string_literal: true

module Boards
  module Commands
    class Create < Command
      def call(params:, user:)
        attrs = Boards::Changesets::Create.map(params).merge({ user: })

        yield create_board(attrs:)

        Success(:success)
      end

      def create_board(attrs:)
        Success(Repositories::BoardRepo.new.create(attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
