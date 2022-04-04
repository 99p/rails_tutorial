require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "user name length 10" do
    @user = User.new
    @user.name = "wowowowowowowowowowowow"
    assert_not @user.valid?
  end

  test "user email length 20" do
    @user = User.new
    @user.name = "wow"
    @user.email = "wo" * 12
    assert_not @user.valid?
  end

  # test "the truth" do
  #   assert true
  # end
end
