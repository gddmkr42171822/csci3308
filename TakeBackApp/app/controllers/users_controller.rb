class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  def new
  	@user = User.new
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "user deleted"
    redirect_to users_url
  end

  def index
    #@user = User.find(params[:id])
    #@projects = @user.projects.paginate(page: params[:page])
    @users = User.all
  end

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Project.where("user_id = ?", id)
  end

  def show
    @user = User.find(params[:id])
    @projects = @user.projects.paginate(page: params[:page])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "welcome to takeback"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  # Before filters
  def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url
      end
    end

  def correct_user
   @user = User.find(params[:id])
   redirect_to(root_url) unless current_user?(@user)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
