class Api::V1::ApiController < ActionController::API

  private

  def render_not_found(exception)
    render status: :not_found, json: "#{controller_name.classify.constantize.model_name.human} não encontrado"
  end

end