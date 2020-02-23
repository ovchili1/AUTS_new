class Teacher::QuestionsController < ApplicationController
  before_action :authorize_access_request!, except: [:create, :update]
  before_action :set_question, only: [:show, :update, :destroy]

  # GET /questions
  def index
    @questions = current_user.questions

    render json: @questions
  end

  # GET /questions/1
  def show
    render json: @question.as_json(include: :answers)
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      render json: @question, status: :created
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.require(:question).permit(:quest_body, :quest_type, :thema_id, :teacher_id, answers_attributes: [:id, :ans_body, :right, :_destroy])
    end
end
