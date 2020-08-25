class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user

  validates :start_date, :end_date, presence:true

  def total
    number_of_days_rental = end_date - start_date
    daily_rate = car_category.daily_price

    number_of_days_rental * daily_rate
  end
end
