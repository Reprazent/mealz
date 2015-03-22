require "test_helper"

describe Meal do
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
end
