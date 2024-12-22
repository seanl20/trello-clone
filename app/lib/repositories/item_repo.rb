module Repositories
  class ItemRepo
    def create(attrs:)
      Item.create!(attrs)
    end

    def get_all(ids:)
      Item.where(id: ids)
    end

    def import_update_all(items_data:)
      items = items_data.map do |item_data|
        item = Item.find(item_data[:id])
        item.position = item_data[:position]
        item.list_id = item_data[:list_id]
        item
      end

      Item.import items, on_duplicate_key_update: { conflict_target: [ :id ], columns: [ :position, :list_id ] }
    end

    def get(id:)
      Item.find(id)
    end
  end
end
