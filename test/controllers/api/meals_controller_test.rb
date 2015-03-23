require "test_helper"

describe Api::MealsController do
  it "can create a meal" do
    meal_params = { meal: { eater_names: ["pjaspers ", "atog", "TomKlaasen", "tomklaasen", "Reprazent"], payed_by_username: "reprazent", amount: "7,9" } }
    assert_difference "Meal.count" do
      post :create, meal_params.merge(format: :json)
    end
    assert_response :created
  end
end
