class Student::TestingsController < ApplicationController
  before_action :authorize_access_request!, except: [:create, :update]
  before_action :set_testing, only: [:show, :update, :destroy]

  # GET /testings
  def index
    @tests = Test.all.as_json(except: [:teacher_id], include: [{teacher: {only: :login}, themas: { only: :name}}])
    @testings = current_user.testings.as_json(except: [:student_id, :test_id], include: [{student: { only: :login}, test: { only: [:name, :num_of_quest]}}])

    render json: [testings: @testings, tests: @tests ]
  end

  # GET /testings/1
  def show
    render json: @testing.as_json(except: [:student_id, :test_id], include:[{student: { only: :login}, test: { only: :name},
                                                                             assem_questions: {include: [:assem_answers, :assem_options]}}])
  end

  # POST /testings
  def create
    @testing = Testing.new(testing_params)

    if @testing.save
      render json: @testing, status: :created, location: @testing
    else
      render json: @testing.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_testing
      @testing = Testing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
  def testing_params
    params.require(:testing).permit(:student_id, :test_id, :percent_Right, :num_of_right_options, :num_of_quest,
                                    assem_questions_attributes: [:id, :quest_body, :right, assem_answers_attributes: [
                                        :id, :ans_body, :right, :weight
                                    ], assem_options_attributes: [
                                        :id, :ans_body, :right, :weight, :student_id
                                    ]])
  end
end
