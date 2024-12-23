# frozen_string_literal: true

module Items
  module Queries
    class GetByList < Query
      def call(item_id:, list:)
        Repositories::ItemRepo.new.get_by_list(id: item_id, list:)
      end
    end
  end
end
