require 'rails_helper'

describe 'Car management' do
  context 'index' do
    it 'renders available cars' do
      subsidiary = Subsidiary.create!(name: 'Unidas', cnpj: '63.463.524/0001-39',
                                    address: 'Rua Santiago')
      car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100,
                                         third_party_insurance: 100)
      car_model = CarModel.create!(name: 'Onix 1.0', year: 2019, manufacturer: 'Chevrolet',
                                   fuel_type: 'Flex', car_category: car_category, motorization: '1.0')
      Car.create!(license_plate: 'ABC1234', color: 'Vermelho', mileage: 1000,
                  car_model: car_model, status: :available, subsidiary: subsidiary)
      Car.create!(license_plate: 'DCF4356', color: 'Preto', mileage: 2000,
                  car_model: car_model, status: :available, subsidiary: subsidiary)
      Car.create!(license_plate: 'FDSE1234', color: 'Preto', mileage: 2000,
                  car_model: car_model, status: :rented, subsidiary: subsidiary)

      get '/api/v1/cars'

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body[0]['license_plate']).to eq('ABC1234')
      expect(body[0]['color']).to eq('Vermelho')
      expect(body[1]['license_plate']).to eq('DCF4356')
      expect(response.body).to include('DCF4356')
      expect(response.body).not_to include('FDSE1234')
      expect(body.count).to eq 2
    end
  end
end