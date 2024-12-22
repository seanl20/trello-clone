# frozen_string_literal: true

module Items
  module Queries
    class Get < Query
      def call(item_id:)
        Repositories::ItemRepo.new.get(id: item_id)
      end
    end
  end
end
