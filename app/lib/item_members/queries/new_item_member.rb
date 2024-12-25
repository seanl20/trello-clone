# frozen_string_literal: true

module ItemMembers
  module Queries
    class NewItemMember < Query
      def call(board:, item:)
        users = Repositories::BoardRepo.new.board_members(board:)
        item_member = item.item_members.new

        return item_member, users
      end
    end
  end
end
