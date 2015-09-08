require "test_helper"

describe Api::UsersController do
  before do
    @users = FactoryGirl.create_list(:user, 2)
    FactoryGirl.create(:archived_user)
  end

  it "lists all users" do
    get :index, format: :json
    assert_equal 2, JSON.parse(response.body).size
  end
end
