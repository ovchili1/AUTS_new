class Admin::TestingsController < ApplicationController
  before_action :authorize_access_request!, except: [:create, :update]
  before_action :set_testing, only: [:show]

  # GET /testings
  def index
    @testings = Testing.all.as_json(except: [:student_id, :test_id], include: [{student: { only: :login}, test: { only: [:name, :num_of_quest]}}])

    render json: [testings: @testings]
  end

  # GET /testings/1
  def show
    render json: @testing
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_testing
      @testing = Testing.find(params[:id])
    end

end
