require 'rails_helper'

feature 'Admin view rental schedule' do
  scenario 'must be logged in' do

    visit root_path
    click_on 'Locações'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'sucessfully' do
    car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, third_party_insurance: 100)
    client = Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-47', email: 'test@client.com')
    user = User.create!(name: 'Lorem Upsum', email: 'lorem@ipsum.com', password: '12345678')
    rental = Rental.create!(start_date: '25/08/2030', end_date: '28/08/2030', 
                            client: client, user: user,car_category: car_category)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'

    expect(page).to have_content(rental.client.name)
    expect(page).to have_content('25/08/2030')
    expect(page).to have_content('28/08/2030')
    expect(page).to have_content(rental.client.cpf)
    expect(page).to have_content(rental.car_category.name)
  end

  scenario 'and there is not rental schedule' do 
    user = User.create!(name: 'Lorem Upsum', email: 'lorem@ipsum.com', password: '12345678')

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'

    expect(page).to have_content('Não há nenhuma locação agendada')
  end


end