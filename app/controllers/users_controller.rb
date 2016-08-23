class UsersController < ApplicationController
	before_action :require_login, only: [:destroy, :edit]

	def index
    @users = User.all
  end

  def new
    if current_user
      redirect_to root_path
    else
    	@user = User.new
    end
  end

  def create
    if current_user
      redirect_to root_path
    else
      @user = User.new(user_params)

      if @user.save
        sign_in(@user)
        flash[:success] = "Congrats on making your account!"

        redirect_to root_path
      else
        errors = @user.errors.full_messages.join(", ")
        flash[:sorry] = "We could not create an accout. #{errors}"
        render :new
      end
    end

  end

  # def show
  #   @profile = User.find(params[:id]).profile
  # end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "You successfully updated your profile."
      redirect_to root_path

    else
      errors = @user.errors.full_messages.join(", ")
      flash[:sorry] = "We could not update your profile. #{errors}"
      render :edit
    end

  end


  private

  def user_params
    params.require(:user).permit(:username, :password,
                                   :password_confirmation)
  end



end
