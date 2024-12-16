module Repositories
  class ListRepo
    def get_by_board(board:)
      List
        .where(board:)
        .order(position: :asc)
    end

    def create(attrs:)
      List.create!(attrs)
    end

    def get(id:, board:)
      List
        .where(board:)
        .find(id)
    end

    def update(id:, attrs:)
      List
        .find(id)
        .update!(attrs)
    end

    def delete(id:)
      List
        .find(id)
        .destroy
    end
  end
end
