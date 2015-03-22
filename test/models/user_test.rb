require "test_helper"

describe User do
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
end
