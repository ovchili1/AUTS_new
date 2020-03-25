class Admin::QuestionsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_question, only: [:show, :update, :destroy]

  # GET /questions
  def index
    @questions = Question.all

    render json: @questions.as_json(except: [:teacher_id, :thema_id], include: [{teacher: { only: :login}, thema: { only: :name}}])
  end

  # GET /questions/1
  def show
    render json: @question
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
      params.require(:question).permit(:quest_body, :thema_id, :teacher_id)
    end
end
