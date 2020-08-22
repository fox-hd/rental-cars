require 'rails_helper'

feature 'admin delete car' do
  scenario 'successfully' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                       third_party_insurance: 10.5)
    car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford',
                                 motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'Unidas', cnpj: '63.463.524/0001-39',
                                    address: 'Rua Santiago')
    Car.create!(license_plate: 'FHI8800', color: 'Cinza',
                car_model: car_model , mileage: 1000, subsidiary: subsidiary)
    car_category = CarCategory.create!(name: 'Econo', daily_rate: 105.5, car_insurance: 58.5,
                                       third_party_insurance: 10.5)
    car_model = CarModel.create!(name: 'Onix', year: 2019, manufacturer: 'Chevrolet',
                                 motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'Localiza', cnpj: '16.790.907/0001-31',
                                    address: 'Rua Santiago')
    Car.create!(license_plate: 'FHI9900', color: 'Cinza',
                car_model: car_model , mileage: 1000, subsidiary: subsidiary)
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')
                    
                        login_as(user, scope: :user)
    visit root_path
    click_on 'Frota de carro'
    click_on 'Unidas'
    click_on 'Apagar'

    expect(page).not_to have_content('Unidas')
    expect(page).to have_content('Localiza')
  end
end