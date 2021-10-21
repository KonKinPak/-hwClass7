require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @test_user = users(:test_user)
  end

#  test "visiting the index" do
#    visit users_url
#    assert_selector "h1", text: "Users"
#  end
#
#  test "creating a User" do
#    visit users_url
#    click_on "New User"
#
#    fill_in "Email", with: @user.email
#    fill_in "Name", with: @user.name
#    fill_in "Password digest", with: @user.password_digest
#    click_on "Create User"
#
#    assert_text "User was successfully created"
#    click_on "Back"
#  end
#
#  test "updating a User" do
#    visit users_url
#    click_on "Edit", match: :first
#
#    fill_in "Email", with: @user.email
#    fill_in "Name", with: @user.name
#    fill_in "Password digest", with: @user.password_digest
#    click_on "Update User"
#
#    assert_text "User was successfully updated"
#    click_on "Back"
#  end
#
#  test "destroying a User" do
#    visit users_url
#    page.accept_confirm do
#      click_on "Destroy", match: :first
#    end
#
#    assert_text "User was successfully destroyed"
#  end




  test "login_fail" do
    visit main_path
    #fill_in "Email", with: @wrong_user.email
    #fill_in "Password", with: @wrong_user.password_digest
    fill_in "Email", with: 'asdlgj'
    fill_in "Password", with: 'agdlsjglS'
    click_on "Log in"
    assert_text "Email/password not valid"
  end
  test "login_success" do
    visit main_path
    fill_in "Email", with: @test_user.email
    fill_in "Password", with: @test_user.password_digest
    #fill_in "Email", with: 'f'
    #fill_in "Password", with: 'ffffffff'
    click_on "Log in"
    assert_text "Login successfully"
  end

end


