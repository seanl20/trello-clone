module Repositories
  class BoardRepo
    def create(attrs:)
      Board.create!(attrs)
    end

    def get(id:)
      Board.find(id)
    end

    def get_by_user(user:)
      Board.where(user:)
    end
  end
end
