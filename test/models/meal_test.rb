require "test_helper"

describe Meal do
  before do
    @meal = FactoryGirl.build(:meal)
  end

  describe "validations" do
    before do
      @meal = Meal.new
    end

    it "needs a payer" do
      assert !@meal.valid?
      assert @meal.errors[:payed_by]
      @meal.payed_by = User.new
      assert @meal.valid?
    end
  end

  it "has many eaters"do
    assert @meal.users.size > 1
  end
end
