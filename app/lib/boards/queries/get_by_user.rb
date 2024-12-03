# frozen_string_literal: true

module Boards
  module Queries
    class GetByUser < Query
      def call(user:)
        Repositories::BoardRepo.new.get_by_user(user:)
      end
    end
  end
end
