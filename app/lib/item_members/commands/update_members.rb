# frozen_string_literal: true

module ItemMembers
  module Commands
    class UpdateMembers < Command
      def call(id:, params:)
        Repositories::ItemRepo.new.update_members(id:, user_ids: params[:user_ids].map(&:to_i).reject(&:zero?))
      end
    end
  end
end
