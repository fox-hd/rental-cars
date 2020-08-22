require 'rails_helper'

feature 'Admin view car' do
  scenario 'must be sign in' do

    visit root_path
    click_on 'Frota de carro'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and view list car by subsidiary' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                       third_party_insurance: 10.5)
    car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford',
                                 motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'Unidas', cnpj: '63.463.524/0001-39',
                                    address: 'Rua Santiago')
    Car.create!(license_plate: 'FHI8800', color: 'Cinza',
                car_model: car_model , mileage: 1000, subsidiary: subsidiary)
    user = User.create!(name: 'João Almeida', email:'joao@gmail.com', password:'123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Frota de carro'
    click_on 'Unidas'
    
    expect(page).to have_content('Unidas')
    expect(page).to have_content('Top')
    expect(page).to have_content('Ka')
    expect(page).to have_content('2019')
    expect(page).to have_content('Ford')
    expect(page).to have_content('FHI8800')
    expect(page).to have_content('Cinza')
    expect(page).to have_content('1000')
  end

  scenario ' and no car create' do
    user = User.create!(name: 'João Almeida', email:'joao@gmail.com', password:'123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Frota de carro'

    expect(page).to have_content('Nenhuma frota de carro cadastrada')
  end
end