module Repositories
  class ItemRepo
    def create(attrs:)
      Item.create!(attrs)
    end
  end
end
