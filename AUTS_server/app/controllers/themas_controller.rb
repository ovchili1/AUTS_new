class ThemasController < ApplicationController
  before_action :set_thema, only: [:show, :update, :destroy]

  # GET /themas
  def index
    @themas = Thema.all

    render json: @themas
  end

  # GET /themas/1
  def show
    render json: @thema
  end

  # POST /themas
  def create
    @thema = Thema.new(thema_params)

    if @thema.save
      render json: @thema, status: :created, location: @thema
    else
      render json: @thema.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /themas/1
  def update
    if @thema.update(thema_params)
      render json: @thema
    else
      render json: @thema.errors, status: :unprocessable_entity
    end
  end

  # DELETE /themas/1
  def destroy
    @thema.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thema
      @thema = Thema.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def thema_params
      params.require(:thema).permit(:name, :teacher_id)
    end
end
