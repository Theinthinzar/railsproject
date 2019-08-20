require 'test_helper'

class MUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @m_user =MUser.new(user_name: "Example User", user_email: "user@example.com",
                       password: "foobar",confirm_password:"foobar")
  end
  test "should be valid" do
    assert @m_user.valid?
  end
  test "name should be present" do
    @m_user.user_name = "     "
    assert_not @m_user.valid?
  end
  test "email should be present" do
    @m_user.user_email = "     "
    assert_not @m_user.valid?
  end
  test "name should not be too long" do
    @m_user.user_name = "a" * 51
    assert_not @m_user.valid?
  end

  test "email should not be too long" do
    @m_user.user_email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @m_user.email = valid_address
      assert @m_user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  test "email addresses should be unique" do
    duplicate_user = @m_user.dup
    duplicate_user.email = @m_user.email.upcase
    @m_user.save
    assert_not duplicate_user.valid?
  end
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
