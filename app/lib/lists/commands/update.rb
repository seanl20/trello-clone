# frozen_string_literal: true

module Lists
  module Commands
    class Update < Command
      def call(id:, params:, board:)
        yield update_list(id:, attrs: Lists::Changesets::Update.map(params))

        Success(list: list_repo.get(id:, board:))
      end

      def update_list(id:, attrs:)
        Success(list_repo.update(id:, attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end

      private

      def list_repo
        Repositories::ListRepo.new
      end
    end
  end
end
