require 'rails_helper'

feature 'Admin view car model from car category' do
  scenario 'must be sign in' do
    
    visit root_path
    click_on 'Categorias'

    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'successfully' do
    car_category_top = CarCategory.create!(name: 'Top', daily_rate: 200,
                        car_insurance: 50, third_party_insurance: 20)
    car_category_econo = CarCategory.create!(name: 'econo', daily_rate: 100,
                        car_insurance: 30, third_party_insurance: 10)
    CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford',
                        motorization: '1.0', car_category: car_category_top, fuel_type: 'Flex')
    CarModel.create!(name: 'Onix', year: 2020, manufacturer: 'Chevrolet',
                        motorization: '1.0', car_category: car_category_econo, fuel_type: 'Flex')
    user = User.create!(name: 'João Almeida', email:'joao@gmail.com', password:'123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'Top'

    expect(page).to have_content('Top')
    expect(page).to have_content('200')
    expect(page).to have_content('50')
    expect(page).to have_content('20')
    expect(page).to have_content('Ka')
    expect(page).to have_content('2019')
    expect(page).to have_content('Ford')
    expect(page).not_to have_content('Onix')
    expect(page).not_to have_content('2020')
    expect(page).not_to have_content('Chevrolet')
  end
end