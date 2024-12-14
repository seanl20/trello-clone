# frozen_string_literal: true

module Lists
  module Commands
    class Create < Command
      def call(params:, board:)
        attrs = Lists::Changesets::Create.map(params).merge({ board: })

        list = yield create_list(attrs:)

        Success(list:)
      end

      def create_list(attrs:)
        Success(Repositories::ListRepo.new.create(attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
