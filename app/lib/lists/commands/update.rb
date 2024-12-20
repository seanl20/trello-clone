# frozen_string_literal: true

module Lists
  module Commands
    class Update < Command
      def call(id:, params:, board:)
        yield update_list(id:, attrs: Lists::Changesets::Update.map(params))

        Success(:success)
      end

      def update_list(id:, attrs:)
        Success(Repositories::ListRepo.new.update(id:, attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
