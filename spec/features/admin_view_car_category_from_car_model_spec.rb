require 'rails_helper'

feature 'Admin view car model from car category' do
  scenario 'successfully' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200,
                        car_insurance: 50, third_party_insurance: 20)
    CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford',
                        motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    CarModel.create!(name: 'Onix', year: 2020, manufacturer: 'Chevrolet',
                        motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
   
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
    expect(page).to have_content('Onix')
    expect(page).to have_content('2020')
    expect(page).to have_content('Chevrolet')
  end
end