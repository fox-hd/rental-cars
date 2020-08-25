require 'rails_helper'

RSpec.describe Rental, type: :model do
  context 'validation' do 
    it 'attributes cannot be blank' do
      rental = Rental.new

      rental.valid?

 
      expect(rental.errors[:start_date]).to include('não pode ficar em branco')
      expect(rental.errors[:end_date]).to include('não pode ficar em branco')
      expect(rental.errors[:client]).to include('é obrigatório(a)')
      expect(rental.errors[:car_category]).to include('é obrigatório(a)')
      expect(rental.errors[:user]).to include('é obrigatório(a)')
    end

  end
end
