class UsersController < ApplicationController
  include MainConcern
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :is_logged_in, only: %i[feed profile]
  def main
    session[:user_id] = nil
  end

  def login
    @email = params[:email]
    @pass = params[:password]
    @user = User.find_by(email:@email)
    respond_to do |format|
      unless(@user.present? && @user.password_digest == @pass)
        format.html { redirect_to main_path , alert: "Email/password not valid" }
      else
        session[:user_id] = @user.id
        format.html{ redirect_to feed_path, notice: "Login successfully"}
      end
    end
    #@user.pass == params[:pass]
    #unless(@user.present? && @user.authenticate(@pass))
    #  redirect_to main_path , alert: "Email/password not valid"
    #else
    #  session[:user_id] = @user.id
    #  redirect_to show3_path, notice: "Login successfully"
    #end
  end

  def register
    @user = User.new
  end

#  def feed #should not be in model
#    @user = User.find(session[:user_id])
#    @posts = []
#    @user.followees.each do |f|
#      f.posts.each do |p|
#        @posts.push(p)
#      end
#    end
#    @posts = @posts.sort().reverse
#  end

  def feed
    @user = User.find(session[:user_id])
    @posts = @user.get_feed_post 
  end

  def profile
    @user = User.find(session[:user_id])
    @profile_user = User.find_by(name:params[:name])
    unless(@profile_user.present?)
      redirect_to feed_path ,alert: "Could not find this user."
    end
  end

  def follow
    profile_user = User.find_by(name:params[:name])
    Follow.create(follower_id:session[:user_id],followee_id:profile_user.id)
    redirect_to profile_path(params[:name]) ,notice: "You just follow " + profile_user.name
  end

  def unfollow
    profile_user = User.find_by(name:params[:name])
    Follow.find_by(follower_id:session[:user_id],followee_id:profile_user.id).destroy
    redirect_to profile_path(params[:name])  ,notice: "You just unfollow " + profile_user.name
  end

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(email:"MyString",name:"MyString",password_digest:"MyString")

    respond_to do |format|
      if @user.save
        format.html { redirect_to "/main", notice: "User was successfully created." }
        format.json { render :main, status: :created , location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      #@user = User.find(session[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :password_digest, :password_digest_confirmation)
    end
end
