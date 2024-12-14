# frozen_string_literal: true

module Lists
  module Queries
    class Get < Query
      def call(id:, board:)
        Repositories::ListRepo.new.get(id:, board:)
      end
    end
  end
end
