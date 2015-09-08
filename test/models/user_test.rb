require "test_helper"

describe User do
  before do
    @user = FactoryGirl.build(:user)
  end

  describe "validations" do
    before do
      User.create(username: "Piet")
      @user = User.new(username: "")
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

  describe "archiving" do
    it "can be archived" do
      assert @user.archive!
      assert @user.archived_at
    end

    it "can be archived" do
      assert @user.unarchive!
      refute @user.archived_at
    end

    it "can find unarchived users" do
      archived_user = FactoryGirl.create(:archived_user)
      unarchived_user = FactoryGirl.create(:user)
      assert User.unarchived.include? unarchived_user
      refute User.unarchived.include? archived_user
    end
  end
end
