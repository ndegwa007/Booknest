require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid_user)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'email should be present' do
    @user.email = 'user@example.com'
    assert_not @user.valid?
  end

  test 'email should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'should authenticate with correct password' do
    assert @user.authenticate('password')
  end

  test 'should not authenticate with incorrect password' do
    assert_not @user.authenticate('wrongpassword')
  end
end
