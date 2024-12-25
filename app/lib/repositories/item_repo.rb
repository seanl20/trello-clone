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

    def get_by_list(id:, list:)
      Item
        .where(list:)
        .find(id)
    end

    def update(id:, attrs:)
      Item
        .find(id)
        .update!(attrs)
    end

    def delete(id:)
      Item
        .find(id)
        .destroy
    end

    def update_members(id:, user_ids:)
      item = Item.find(id)

      item_user_ids = item.members.ids

      user_ids_to_destory = item_user_ids - user_ids

      ItemMember.where(item:, user_id: user_ids_to_destory).delete_all

      users_to_assign = User.where(id: user_ids).where.not(id: item.reload.members.ids)

      item.members << users_to_assign
    end
  end
end
