require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new
    @user.name                  = 'John Doe'
    @user.email                 = 'nice@example.com'
    @user.password              = 'foobar'
    @user.password_confirmation = 'foobar'
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name =  ''
    assert @user.invalid?
  end

  test 'name should not be not too long' do
    @user.name =  'a' * 51
    assert @user.invalid?
  end

  test 'email should be present' do
    @user.email =  ' '
    assert @user.invalid?
  end

  test 'email should not be not too long' do
    @user.name =  'a' * 244 + '@example.com'
    assert @user.invalid?
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com Noi$$@wow.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert @user.invalid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert duplicate_user.invalid?
  end

  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = " " * 6
    assert @user.invalid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = "a" * 5
    assert @user.invalid?
  end

end
