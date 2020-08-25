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
    
    context 'token' do
      it 'generate on create' do
        client = Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-47', 
                                email: 'test@client.com')
        car_category = CarCategory.create!(name: 'A', car_insurance: 100, 
                                           daily_rate: 100, third_party_insurance: 100)
        user = User.create!(name: 'Lorem Upsum', email: 'lorem@ipsum.com',
                            password: '12345678')
        rental = Rental.new(start_date: Date.current, end_date: 1.day.from_now,
                            client: client, car_category: car_category, user: user)

        rental.save!  
        rental.reload

        expect(rental.token).to be_present
        expect(rental.token.size).to eq(6)
        expect(rental.token).to match(/^[A-Z0-9]+$/)
      end
    end
  end
end
