require 'rails_helper'

feature 'admin edit car' do

  scenario 'mus be sign in' do
    visit root_path
    click_on 'Modelos de carro'

    expect(current_path).to eq new_user_session_path
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
    car_category = CarCategory.create!(name: 'Econo', daily_rate: 205.5, car_insurance: 68.5,
                                       third_party_insurance: 15.5)
    car_model = CarModel.create!(name: 'Onix', year: 2020, manufacturer: 'Chevrolet',
                                 motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'Localiza', cnpj: '16.790.907/0001-31',
                                    address: 'Rua Santos')
    
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Frota de carro'
    click_on 'Unidas'
    click_on 'Editar'
    fill_in 'Placa', with: 'FHI9900'
    fill_in 'Cor', with: 'Preto'
    fill_in 'Kilometragem', with: 2000
    select 'Onix', from: 'Modelo do carro'
    select 'Localiza', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('FHI9900')
    expect(page).to have_content('Preto')
    expect(page).to have_content('2000')
    expect(page).to have_content('Onix')
    expect(page).to have_content('Localiza')
    expect(page).to have_link('Voltar', href: cars_path)
  end

  scenario 'and attributes not can be blank' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                       third_party_insurance: 10.5)
    car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford',
                                 motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'Unidas', cnpj: '63.463.524/0001-39',
                                    address: 'Rua Santiago')
    Car.create!(license_plate: 'FHI8800', color: 'Cinza',
                car_model: car_model , mileage: 1000, subsidiary: subsidiary)
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Frota de carro'
    click_on 'Unidas'
    click_on 'Editar'
    fill_in 'Placa', with: ''
    fill_in 'Cor', with: ''
    fill_in 'Kilometragem', with: ''
    select 'Ka', from: 'Modelo do carro'
    select 'Unidas', from: 'Filial'
    click_on 'Enviar'
    

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
end