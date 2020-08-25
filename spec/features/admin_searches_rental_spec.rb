require 'rails_helper'

feature 'Admin searche rental' do
  scenario 'and find exact match' do
    client = Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-47', 
                            email: 'test@client.com')
    car_category = CarCategory.create!(name: 'A', car_insurance: 100, 
                                       daily_rate: 100, third_party_insurance: 100)
    user = User.create!(name: 'Lorem Upsum', email: 'lorem@ipsum.com',
                        password: '12345678')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                        client: client, car_category: car_category, user: user)
    another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                                    client: client, car_category: car_category, user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'

    expect(page).to have_content(rental.token)
    expect(page).not_to have_content(another_rental.token)
    expect(page).to have_content(rental.client.name)
    expect(page).to have_content(rental.client.email)
    expect(page).to have_content(rental.client.cpf)
    expect(page).to have_content(rental.user.email)
    expect(page).to have_content(rental.car_category.name)
  end
end