module Api
  class MealsController < ::ApiController
    respond_to :json

    def create
      @meal = MealBuilder.new(meal_params).create_meal
      respond_with @meal, location: nil
    end

    def meal_params
      params.require(:meal)
    end
  end
end
