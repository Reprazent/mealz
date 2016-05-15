require "test_helper"

describe Api::MealsController do
  it "can create a meal" do
    meal_params = { meal: { eater_names: ["pjaspers ", "atog", "TomKlaasen", "tomklaasen", "Reprazent"], payed_by_username: "reprazent", amount: "7,9" } }
    assert_difference "Meal.count" do
      post :create, meal_params.merge(format: :json)
    end
    assert_response :created
  end

  it "returns the balance of the payer" do
    meal_params = { meal: { eater_names: ["pjaspers ", "atog", "TomKlaasen", "tomklaasen", "Reprazent"], payed_by_username: "reprazent", amount: "7,9" } }
    post :create, meal_params.merge(format: :json)
    body = JSON.parse(response.body)
    assert_equal 5.925, body["meal"]["payed_by"]["balance"]
  end

  it "Can delete a meal." do
    meal_params = { eater_names: ["pjaspers ", "atog", "TomKlaasen", "tomklaasen", "Reprazent"], payed_by_username: "reprazent", amount: "7,9" }
    builder = MealBuilder.new(meal_params)
    meal = builder.create_meal
    meal.save

    assert_difference("Meal.count", -1) do
      delete :destroy, id: meal.id, format: :json
    end

    # make sure all users have 0 as their balance.
    assert_equal [], User.all.map(&:balance).map(&:round) - [0]
  end
end
