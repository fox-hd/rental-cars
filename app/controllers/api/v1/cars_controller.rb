class Api::V1::CarsController < Api::V1::ApiController

  def index
    render json: Car.available, status: 200
    #render json: Car.available.as_json(include: {car_model: {include: :car_category}}, except: :car_model_id), status: 200
  end

  def show
    #@car = Car.find_by(id: params[:id])
    #return render json: @car if @car

    #render status: :not_found, json: ''
    @car = Car.find(params[:id])
    render json: @car if @car
  #rescue StandardError -> Ruby herda dessa classe - resgata todos os erros mas nao é o ideal
  end

  def create
    #@car = Car.new(car_params)
    #if @car.save
    #  render status: :created, json: @car
    #else
    #  render status: :unprocessable_entity, json: @car.errors.full_messages
    #end
    @car = Car.new(car_params)
    @car.save!
    render status: :created, json: @car

  rescue ActionController::ParameterMissing
    render status: :precondition_failed, json: 'Parâmetros inválidos'
  end


  private

  def car_params
    params.require(:car).permit(:license_plate, :color, :mileage, :car_model_id, :subsidiary_id)
  end


end