# frozen_string_literal: true

module BoardUsers
  module Commands
    class UpdateMembers < Command
      def call(id:, params:)
        Repositories::BoardRepo.new.update_members(user_ids: params[:user_ids].map(&:to_i).reject(&:zero?))
      end
    end
  end
end
