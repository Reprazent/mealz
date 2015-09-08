require "test_helper"

describe MealBuilder do
  before do
    @builder = MealBuilder.new({})
  end

  it "can parse the amount payed" do
    @builder.meal_params = { amount: "7,3" }
    assert_equal 7.3, @builder.amount
  end

  it "returns nil for invalid amounts" do
    @builder.meal_params = { amount: "this is not even a number" }
    refute @builder.amount
  end

  it "can build a payed_by user" do
    @builder.meal_params = { payed_by_username: "Reprazent " }
    assert_equal "reprazent", @builder.payed_by.username
  end

  it "can collect names for all eaters" do
    @builder.meal_params = { eater_names: ["pjaspers ", "atog", "TomKlaasen", "tomklaasen"] }
    assert_equal ["pjaspers", "atog", "tomklaasen"], @builder.eater_names
  end

  it "can build a user collection including the payer" do
    @builder.meal_params = { eater_names: ["pjaspers ", "atog", "TomKlaasen", "tomklaasen", "Reprazent"], payed_by_username: "reprazent" }
    assert_equal 4, @builder.users.size
    assert_equal ["pjaspers", "reprazent", "atog", "tomklaasen"].sort, @builder.users.map(&:username).sort
  end

  it "can unarchive the users" do
    user = FactoryGirl.create(:user)
    @builder.expects(:users).returns([user])
    user.expects(:unarchive!)
    @builder.unarchive_users!
  end

  it "can build a meal" do
    @builder.meal_params = { eater_names: ["pjaspers ", "atog", "TomKlaasen", "tomklaasen", "Reprazent"], payed_by_username: "reprazent", amount: "7,9" }
    meal = @builder.build_meal
    assert_equal meal.payed_by.username, "reprazent"
    assert_equal 7.9, meal.amount
    assert meal.valid?
  end

  describe "Saving a meal" do
    before do
      @builder.meal_params = { eater_names: ["pjaspers ", "atog", "TomKlaasen", "tomklaasen", "Reprazent"], payed_by_username: "reprazent", amount: "7,9" }
    end

    it "it recalculates balances when creating a meal" do
      @builder.expects(:recalculate_balances!)
      @builder.create_meal
    end

    it "unarchives all the users" do
      @builder.expects(:unarchive_users!)
      @builder.create_meal
    end

    it "saves a meal" do
      assert @builder.create_meal.persisted?
    end

    it "returns a meal with errors if invalid" do
      @builder.meal_params.merge!(amount: "geen amount")
      assert @builder.create_meal.errors[:amount].any?
    end

  end

  describe "balances" do
    before do
      @payer = FactoryGirl.create(:user, balance: 10.5)
      @eater = FactoryGirl.create(:user, balance: 20.5)
      meal = FactoryGirl.create(:meal, amount: 5, payed_by: @payer, users: [@payer, @eater])
      @builder.meal = meal
    end

    it "calculates the balances for the user" do
      @builder.recalculate_balances!
      assert_equal 13, @payer.reload.balance
      assert_equal 18, @eater.reload.balance
    end
  end

end
