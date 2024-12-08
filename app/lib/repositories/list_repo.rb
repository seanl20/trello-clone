module Repositories
  class ListRepo
    def get_by_board(board:)
      List.where(board:)
    end
  end
end
