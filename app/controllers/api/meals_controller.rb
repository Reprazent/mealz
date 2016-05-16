module Api
  class MealsController < ::ApiController
    respond_to :json
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
      @meal = MealBuilder.new(meal_params).create_meal
      respond_with @meal, location: nil
    end

    def destroy
      if MealDestroyer.new(params[:id]).destroy_meal
        @users = User.unarchived.order("balance ASC")
        render json: @users, location: nil, root: false
      else
        render json: { error: "You broke all the things!" }, location: nil
      end
    end

    def meal_params
      params.require(:meal)
    end

    private

    def record_not_found
      render json: { error: "Meal not found." }, location: nil, status: :not_found
    end

  end
end
