class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @boards = Boards::Queries::GetByUser.new.call(user: current_user)
  end
end
