class UsersController < ApplicationController

  # GET /users/1
  def show
    render json: current_user
  end

  # PATCH/PUT /users/1
  def update
    if current_user.update(user_params)
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
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:login, :email, :password, :password_confirmation, :type)
    end
end
