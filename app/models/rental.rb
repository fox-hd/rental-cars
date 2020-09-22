class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user
  has_one :car_rental

  validates :start_date, :end_date, presence:true

  before_create :generate_token

  #def scheduled?
  #  car_rented.blank?
  #end

  #def in_progress?
  #  car_rental && car_rental.end_date.blank?
  #end

  #def finalized?
  #  car_rental && car_rental.end_date.presente?
  #end
  

  def total
    number_of_days_rental = end_date - start_date
    daily_rate = car_category.daily_price

    number_of_days_rental * daily_rate
  end

  private

  def generate_token
    self.token = SecureRandom.alphanumeric(6).upcase
  end

end
