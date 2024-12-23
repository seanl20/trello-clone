# frozen_string_literal: true

module Items
  module Commands
    class Delete < Command
      def call(id:)
        yield delete_item(id:)

        Success(:success)
      end

      def delete_item(id:)
        Success(Repositories::ItemRepo.new.delete(id:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
