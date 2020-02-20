class UsersController < ApplicationController
  before_action :authorize_access_request!, except: [:all_teachers, :update]
  before_action :user_find, only: [:update]

  def all_teachers
    @teachers = User.all.where(type: "Teacher")
    render json: @teachers
  end
  def me
    render json: current_user.as_json(only: [:id,:login, :email, :type])
  end
  # GET /users/1
  def show
    render json: current_user.as_json(only: [:id,:login, :email, :type])
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    current_user.destroy
  end

  private
  def user_find
    @user = User.find(params[:id])
  end
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:login, :email, :password, :password_confirmation, :type)
    end
end
