# frozen_string_literal: true

module Items
  module Commands
    class Update < Command
      def call(id:, params:)
        yield update_item(id:, attrs: Items::Changesets::Update.map(params))

        Success(:success)
      end

      def update_item(id:, attrs:)
        Success(Repositories::ItemRepo.new.update(id:, attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
