require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
    @user = users(:user1)
  end
#
#  test "visiting the index" do
#    visit posts_url
#    assert_selector "h1", text: "Posts"
#  end
#
#  test "creating a Post" do
#    visit posts_url
#    click_on "New Post"
#
#    fill_in "Msg", with: @post.msg
#    fill_in "User", with: @post.user_id
#    click_on "Create Post"
#
#    assert_text "Post was successfully created"
#    click_on "Back"
#  end
#
#  test "updating a Post" do
#    visit posts_url
#    click_on "Edit", match: :first
#
#    fill_in "Msg", with: @post.msg
#    fill_in "User", with: @post.user_id
#    click_on "Update Post"
#
#    assert_text "Post was successfully updated"
#    click_on "Back"
#  end
#
#  test "destroying a Post" do
#    visit posts_url
#    page.accept_confirm do
#      click_on "Destroy", match: :first
#    end
#
#    assert_text "Post was successfully destroyed"
#  end
	test "like" do
  	#user_name = f
	  	#session[:user_id] = '1'
    	visit main_path
    	fill_in "Email", with: "one"
    	fill_in "Password", with: "one"
    	#fill_in "Email", with: 'f'
    	#fill_in "Password", with: 'ffffffff'
    	click_on "Log in"
	  	@posts = @user.get_feed_post
	    post = @posts.first
	    profile_user_name = User.find(post.user_id).name
	    click_button 'Like'
	    visit "/profile/#{profile_user_name}"
	    click_button '1 Likes'
	    assert_text "one"
	end
end
