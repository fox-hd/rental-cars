require 'rails_helper'

describe Car, type: :model do
  context 'validation' do
      it 'attributes cannot be blank' do
        car = Car.new

        car.valid?

        expect(car.errors[:license_plate]).to include('não pode ficar em branco')
        expect(car.errors[:mileage]).to include('não pode ficar em branco')
        expect(car.errors[:color]).to include('não pode ficar em branco')
        expect(car.errors[:car_model]).to include('é obrigatório(a)')
        expect(car.errors[:subsidiary]).to include('é obrigatório(a)')
      end

      it 'license plate must be unique and not is sensitive' do
      car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                         third_party_insurance: 10.5)
      car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford',
                                   motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
      subsidiary = Subsidiary.create!(name: 'Unidas', cnpj: '63.463.524/0001-39',
                                      address: 'Rua Santiago')
      Car.create!(license_plate: 'FHI8800', color: 'Cinza',
                  car_model: car_model , mileage: 1000, subsidiary: subsidiary)
      
      car = Car.new(license_plate: 'Fhi8800', color: 'Preto', car_model: car_model, mileage: 8000, subsidiary: subsidiary)

      car.valid?

      expect(car.errors[:license_plate]).to include('já está em uso')
      end

      it 'mileage must be some number' do
        car = Car.new(mileage: 'abc')

        car.valid?

        expect(car.errors[:mileage]).to include('não é um número')
      end

      it 'mileage must be greatr than 0' do
        car = Car.new(mileage: 0)

        car.valid?

        expect(car.errors[:mileage]).to include('deve ser maior que 0')
      end
  end
  context 'description' do
    it 'should return car model name, color and license plate' do
      car_category = CarCategory.create!(name: 'A', car_insurance: 100, 
                                         daily_rate: 50, third_party_insurance: 30)
      car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford',
                                  motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
      subsidiary = Subsidiary.create!(name: 'Unidas', cnpj: '63.463.524/0001-39',
                                      address: 'Rua Santiago')
      car =  Car.new(license_plate: 'ABC123', color: 'Prata',
                     car_model: car_model, mileage: 100, subsidiary: subsidiary)

      result = car.description

      expect(result).to eq 'Ka - Prata - ABC123'
    end
  end
end