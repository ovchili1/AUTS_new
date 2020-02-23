class ThemasController < ApplicationController

  # GET /themas
  def index
    @themas = Thema.all.order(:id)

    render json: @themas.as_json(include: :questions)
  end

end
