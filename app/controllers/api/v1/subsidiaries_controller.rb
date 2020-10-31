class Api::V1::SubsidiariesController < Api::V1::ApiController

  def index
    render json: Subsidiary.all
  end


end