require 'rails_helper'

feature 'Admin edits car model' do
  scenario 'must be sign in' do
    
    visit root_path
    click_on 'Modelos de carro'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50,
                        third_party_insurance: 20)
    CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford',
                     motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    user = User.create!(name: 'João Almeida', email:'joao@gmail.com', password:'123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Ka - 2019'
    click_on 'Editar'
    fill_in 'Nome', with:'Onix'
    fill_in 'Ano', with: '2020'
    fill_in 'Fabricante', with: 'Chevrolet'
    fill_in 'Motorização', with: '1.6'
    fill_in 'Tipo de combustível', with: 'Gasolina'
    click_on 'Enviar'

    expect(page).to have_content('Onix')
    expect(page).to have_content('2020')
    expect(page).to have_content('1.6')
    expect(page).to have_content('Gasolina')
  end

  scenario 'and attributes cannot be blank' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50,
                        third_party_insurance: 20)
    CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford',
                     motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    user = User.create!(name: 'João Almeida', email:'joao@gmail.com', password:'123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Ka - 2019'
    click_on 'Editar'
    fill_in 'Nome', with:''
    fill_in 'Ano', with: ''
    select 'Top', from: 'Categoria de carro'
    fill_in 'Fabricante', with: ''
    fill_in 'Motorização', with: ''
    fill_in 'Tipo de combustível', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 5)
    
  end
end