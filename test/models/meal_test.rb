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
      @meal.valid?
      assert @meal.errors[:payed_by].any?
      @meal.payed_by = User.new
      @meal.valid?
      assert @meal.errors[:payed_by].empty?
    end

    it "needs eaters including the payer" do
      @meal.valid?
      assert_equal 2, @meal.errors[:users].size
      @meal.users << FactoryGirl.build(:user)
      @meal.valid?
      assert_equal 1, @meal.errors[:users].size
      @meal.payed_by = FactoryGirl.build(:user)
      @meal.users << @meal.payed_by
      assert @meal.valid?
    end
  end

  it "has many eaters"do
    assert @meal.users.size > 1
  end
end
