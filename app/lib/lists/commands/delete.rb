# frozen_string_literal: true

module Lists
  module Commands
    class Delete < Command
      def call(id:)
        list = yield delete_list(id:)

        Success(list:)
      end

      def delete_list(id:)
        Success(Repositories::ListRepo.new.delete(id:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
