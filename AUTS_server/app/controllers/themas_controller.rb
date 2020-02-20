class ThemasController < ApplicationController

  # GET /themas
  def index
    @themas = Thema.all.order(:id)

    render json: @themas
  end

end
