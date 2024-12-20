# frozen_string_literal: true

module Items
  module Commands
    class UpdatePosition < Command
      def call(items_data:)
        item_repo.import_update_all(items_data:)

        get_items(items_data:)
      end

      def get_items(items_data:)
        items_ids = items_data.map { |item| item[:id] }
        items = item_repo.get_all(ids: items_ids)

        puts items.inspect
      end

      private

      def item_repo
        Repositories::ItemRepo.new
      end
    end
  end
end
