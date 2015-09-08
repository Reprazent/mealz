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

  it "can archive a user" do
    @user = @users.first
    delete :destroy, id: @user.username, format: :json
    assert_response :success
    assert @user.reload.archived_at
  end

  it "replies 404 when applicable" do
    delete :destroy, id: "bloe" , format: :json
    assert_response :not_found
  end
end
