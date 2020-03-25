class Student::TestsController < ApplicationController
  before_action :set_test

  # GET /tests/1
  def show
    render json: @test.as_json(include: {themas: {include: {questions: {include: :answers}}}})
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

end
