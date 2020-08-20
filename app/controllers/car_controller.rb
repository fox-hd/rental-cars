class CarController < ApplicationController

  def index
    @cars = Car.all
  end


end