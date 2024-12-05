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
  end
end
