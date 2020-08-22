class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary

  validates :license_plate, :mileage, :color, presence:true
  validates :license_plate, uniqueness: {case_sensitive: false}
  validates :mileage, numericality: {greater_than: 0}

end
