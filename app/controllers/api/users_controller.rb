module Api
  class UsersController < ::ApiController
    respond_to :json
    def index
      @users = User.unarchived.order("balance ASC")
      respond_with @users, location: nil, root: false
    end

    def destroy
      @user = User.find_by_username(params[:id].downcase.strip)
      return render nothing: true, status: :not_found unless @user
      @user.archive!
      respond_with @user, location: nil
    end
  end
end
