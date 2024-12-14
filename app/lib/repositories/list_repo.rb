module Repositories
  class ListRepo
    def get_by_board(board:)
      List.where(board:)
    end

    def create(attrs:)
      List.create!(attrs)
    end

    def get(id:, board:)
      List
        .where(board:)
        .find(id)
    end
  end
end
