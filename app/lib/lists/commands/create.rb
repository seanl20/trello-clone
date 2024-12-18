# frozen_string_literal: true

module Lists
  module Commands
    class Create < Command
      def call(params:, board:)
        position = get_lastest_list_position(board:)
        attrs = Lists::Changesets::Create.map(params).merge({ board:, position: })

        list = yield create_list(attrs:)

        Success(list:)
      end

      def create_list(attrs:)
        Success(list_repo.create(attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end

      def get_lastest_list_position(board:)
        lists = list_repo.get_by_board(board:)

        lists.blank? ? 0 : lists.last.position + 1
      end

      def list_repo
        Repositories::ListRepo.new
      end
    end
  end
end
