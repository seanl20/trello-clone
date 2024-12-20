# frozen_string_literal: true

module Lists
  module Commands
    class Delete < Command
      def call(id:)
        yield delete_list(id:)

        Success(:success)
      end

      def delete_list(id:)
        Success(Repositories::ListRepo.new.delete(id:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
