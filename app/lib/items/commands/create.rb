# frozen_string_literal: true

module Items
  module Commands
    class Create < Command
      def call(params:, list:)
        attrs = Items::Changesets::Create.map(params).merge({ list: })

        yield create_items(attrs:)

        Success(:success)
      end

      def create_items(attrs:)
        Success(Repositories::ItemRepo.new.create(attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
