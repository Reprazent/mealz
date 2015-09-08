module Api
  class UsersController < ::ApiController
    respond_to :json
    def index
      @users = User.unarchived.order("balance ASC")
      respond_with @users, location: nil, root: false
    end
  end
end
