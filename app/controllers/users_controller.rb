class UsersController < ApplicationController

	# Will be used to implement Edit and Update profile functionality
	before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def new
  	@user = User.new
		@title = "Sign Up"
  end
				 
	def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
    	sign_in @user
    	flash[:success] = "Welcome to the Sample App!"
      redirect_to user_path(@user)
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  private

		# Will be used to implement Edit and Update profile functionality
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
end
