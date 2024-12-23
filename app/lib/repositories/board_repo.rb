module Repositories
  class BoardRepo
    def create(attrs:)
      Board.create!(attrs)
    end

    def update(id:, attrs:)
      Board
        .find(id)
        .update!(attrs)
    end

    def get(id:)
      Board.find(id)
    end

    def get_by_user(user:)
      Board.where(user:).order(:created_at)
    end

    def delete(id:)
      Board
        .find(id)
        .destroy
    end

    def update_members(id:, user_ids:)
      board = Board.find(id)

      board_user_ids = board.members.where.not(id: board.user_id).ids

      user_ids_to_destory = board_user_ids - user_ids

      BoardUser.where(board:, user_id: user_ids_to_destory).delete_all

      users_to_assign = User.where(id: user_ids)

      board.members << users_to_assign
    end
  end
end
