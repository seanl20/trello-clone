# frozen_string_literal: true

module Boards
  module Queries
    class Get < Query
      def call(id:)
        Repositories::BoardRepo.new.get(id:)
      end
    end
  end
end
