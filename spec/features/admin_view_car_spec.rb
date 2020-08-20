require 'rails_helper'

feature 'Admin view car' do
  xscenario 'must be sign in' do

    visit root_path
    click_on 'Cadastrar carro para frota da filial'

    expect(current_path).to eq 
  end

  scenario 'successfully' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                       third_party_insurance: 10.5)
    car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford',
                                 motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'Unidas', cnpj: '63.463.524/0001-39',
                                    address: 'Rua Santiago')
    Car.create!(license_plate: 'FHI8800', color: 'Cinza',
                car_model: car_model , mileage: 1000, subsidiary: subsidiary)

    visit root_path
    click_on 'Frota de carro'
    
    expect(page).to have_content('Unidas')
  end

end