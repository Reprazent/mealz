require "test_helper"

describe User do
  before do
    @user = FactoryGirl.build(:user)
  end

  describe "validations" do
    before do
      User.create(username: "Piet")
      @user = User.new
    end

    it "needs a unique username" do
      assert !@user.valid?
      @user.username = "piet"
      assert !@user.valid?
      assert @user.errors[:username]
      @user.username = "bram"
      assert @user.valid?
    end
  end

  it "has has many meals" do
    @user.meals = FactoryGirl.build_list(:meal, 2)
    @user.save!
    assert @user.meals.size == 2
  end
end
