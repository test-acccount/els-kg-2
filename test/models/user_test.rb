require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:kim)
  end

  test "locale should be one from list of available locales" do
    @user.locale = "zz"
    assert_not @user.valid?

    @user.locale = "ru"
    assert @user.valid?

    @user.locale = "rus"
    assert_not @user.valid?
  end
end
