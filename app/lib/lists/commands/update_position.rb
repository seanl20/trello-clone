# frozen_string_literal: true

module Lists
  module Commands
    class UpdatePosition < Command
      def call(id:, board_id:, position:)
        lists = get_lists(board_id:).to_a
        lists = update_list_postion(list_id: id, lists:, position:)
        update_list_data(lists:)

        get_lists(board_id:)
      end

      def get_lists(board_id:)
        Lists::Queries::GetByBoard.new.call(board_id:)
      end

      def update_list_postion(list_id:, lists:, position:)
        delete_index = lists.index { |list| list.id == list_id.to_i }
        list = lists.delete_at(delete_index)
        lists.insert(position.to_i, list)
      end

      def update_list_data(lists:)
        lists.each_with_index do |list, index|
          list.position = index
        end

        List.import lists, on_duplicate_key_update: { conflict_target: [ :id ], columns: [ :position ] }
      end
    end
  end
end
