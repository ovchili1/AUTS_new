class Admin::UsersController < ApplicationController
  before_action :authorize_access_request!, except: [:update]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all.order(:id)

    render json: @users.as_json(only: [:id,:login, :email, :type])
  end

  # GET /users/1
  def show
    render json: @user.as_json(only: [:id,:login, :email, :type, :password, :password_confirmation])
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
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:id, :login, :email, :password, :password_confirmation, :type)
    end
end
