class RentalsController < ApplicationController
  
  def index
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
    @clients = Client.all
    @car_categories = CarCategory.all
  end

  def create
    rental_params = params.require(:rental).permit(:start_date, :end_date, 
                                                    :client_id, :car_category_id)
    @rental = Rental.new(rental_params)
    @rental.user = current_user
    @rental.save!
    redirect_to @rental, notice: 'Agendamento realizado com sucesso!'
  end

end