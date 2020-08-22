require 'rails_helper'

feature 'Admin register car' do
  scenario 'and must be sign in' do

    visit root_path
    click_on 'Frota de carro'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'from index page' do
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Frota de carro'

    expect(page).to have_link('Registrar novo carro')
  end

  scenario 'successfully' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                       third_party_insurance: 10.5)
    car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford',
                                 motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'Unidas', cnpj: '63.463.524/0001-39',
                                    address: 'Rua Santiago')
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Frota de carro'
    click_on 'Registrar novo carro'
    fill_in 'Placa', with: 'FHI8800'
    fill_in 'Cor', with: 'Cinza'
    fill_in 'Kilometragem', with: 1000
    select 'Ka', from: 'Modelo do carro'
    select 'Unidas', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('FHI8800')
    expect(page).to have_content('Cinza')
    expect(page).to have_content('1000')
    expect(page).to have_content('Ka')
    expect(page).to have_content('Unidas')
  end

  scenario 'and must fill all fields' do
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as(user, scope: :user)

    visit root_path
    click_on 'Frota de carro'
    click_on 'Registrar novo carro'
    click_on 'Enviar'

    expect(page).to have_content('Placa do carro não pode ficar em branco')
    expect(page).to have_content('Cor não pode ficar em branco')
    expect(page).to have_content('Kilometragem não pode ficar em branco')
    expect(page).to have_content('Modelo do carro é obrigatório')
    expect(page).to have_content('Filial é obrigatório(a)')
    expect(page).to have_link('Voltar')
  end
  
  scenario 'and license plate must be unique' do
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
    click_on 'Registrar novo carro'
    fill_in 'Placa', with: 'FHI8800'
    fill_in 'Cor', with: 'Cinza'
    fill_in 'Kilometragem', with: 1000
    select 'Ka', from: 'Modelo do carro'
    select 'Unidas', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Placa do carro já está em uso')
  end
end