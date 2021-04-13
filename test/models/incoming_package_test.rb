require 'test_helper'

class IncomingPackageTest < ActiveSupport::TestCase
  setup do
    @incoming_package = incoming_packages(:one)
  end

  test "tracking should be present" do
    @incoming_package.tracking = nil
    assert_not @incoming_package.valid?
  end

  test "tracking should be uniq" do
    incoming_package_copy = @incoming_package.dup
    assert_not incoming_package_copy.save
  end
end
