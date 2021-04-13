require 'test_helper'

class PassportTest < ActiveSupport::TestCase
  setup do
    @passport = passports(:kim)
  end

  test "first_name should present" do
    @passport.first_name = nil
    assert_not @passport.valid?
  end

  test "last_name should present" do
    @passport.last_name = nil
    assert_not @passport.valid?
  end

  test "phone should present" do
    @passport.phone = nil
    assert_not @passport.valid?
  end

  test "address_line should present" do
    @passport.address_line = nil
    assert_not @passport.valid?
  end

  test "address_zipcode should present" do
    @passport.address_zipcode = nil
    assert_not @passport.valid?
  end

  test "address_city should present" do
    @passport.address_city = nil
    assert_not @passport.valid?
  end
end
