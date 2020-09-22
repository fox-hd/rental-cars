require 'rails_helper'

feature 'User start rental' do
  scenario 'view only category cars' do
    client = Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-47', 
                            email: 'test@client.com')
    user = User.create!(name: 'Lorem Upsum', email: 'lorem@ipsum.com',
                        password: '12345678')
    subsidiary = Subsidiary.create!(name: 'Unidas', cnpj: '63.463.524/0001-39',
                                    address: 'Rua Santiago')
    car_category_a = CarCategory.create!(name: 'A', car_insurance: 100, 
                                         daily_rate: 50, third_party_insurance: 30)
    model_ka = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford',
                                motorization: '1.0', car_category: car_category_a, fuel_type: 'Flex')
    car_category_esp = CarCategory.create!(name: 'Especial', car_insurance: 500, 
                                           daily_rate: 150, third_party_insurance: 300)
    model_fusion = CarModel.create!(name: 'Fusion Hybrid', year: 2020, manufacturer: 'Ford',
                                motorization: '2.2', car_category: car_category_esp, fuel_type: 'Elétrico')
    car =  Car.create!(license_plate: 'ABC123', color: 'Prata',
                                car_model: model_ka, mileage: 100, subsidiary: subsidiary, status: :available)
    car_fusion =  Car.create!(license_plate: 'XYZ9876', color: 'Azul',
                       car_model: model_fusion, mileage: 100, subsidiary: subsidiary, status: :available)
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                            client: client, car_category: car_category_a, user: user)
    
    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Iniciar locação'
    
    expect(page).to have_content('Ka')
    expect(page).to have_content('Prata')
    expect(page).to have_content('ABC123')
    expect(page).not_to have_content('Fusion')
    expect(page).not_to have_content('Azul')
    expect(page).not_to have_content('XYZ9876')
  end

  scenario 'successfully' do
    client = Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-47', 
                            email: 'test@client.com')
    user = User.create!(name: 'Lorem Upsum', email: 'lorem@ipsum.com',
                        password: '12345678')
    subsidiary = Subsidiary.create!(name: 'Unidas', cnpj: '63.463.524/0001-39',
                                    address: 'Rua Santiago')
    car_category = CarCategory.create!(name: 'A', car_insurance: 100, 
                                       daily_rate: 50, third_party_insurance: 30)
    car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford',
                                motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    car =  Car.create!(license_plate: 'ABC123', color: 'Prata',
                       car_model: car_model, mileage: 100, subsidiary: subsidiary)
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                            client: client, car_category: car_category, user: user)
    user = User.create!(name: 'Outra pessoa', email: 'another@test.com',
                        password: '12345678')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Iniciar locação'
    select "#{car_model.name} - #{car.color} - #{car.license_plate}", 
            from: 'Carros disponiveis'
    fill_in 'CNH do condutor', with: 'RJ200100-10'
    #TODO: pegar nome e cnh do condutor, foto do carro
    travel_to Time.zone.local(2020, 10, 01, 12, 30, 45) do
    click_on 'Iniciar'
    end

    expect(page).to have_content(car_category.name)
    expect(page).to have_content(client.email)
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)

    expect(page).to have_content('Locação iniciada com sucesso')
    expect(page).to have_content(user.email)
    expect(page).to have_content(car_model.name)
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(car.color)
    expect(page).to have_content('RJ200100-10')
    expect(page).not_to have_link('Iniciar locação')
    expect(page).to have_content("01 de outubro de 2020, 12:30:45")
    expect(car.reload).to be_rented
    expect(page).to have_content('Em andamento')
  end

  scenario 'view only available cars' do
    user = User.create!(email: 'user@test.com', password: '12345678',
                        name: 'Sicrano Fulano')
    client = Client.create!(name: 'Fulano Sicrano', email: 'client@test.com',
                            cpf: '893.203.383-88')

    car_category_a = CarCategory.create!(name: 'A', daily_rate: 100,
                                        car_insurance: 50,
                                        third_party_insurance: 30)

    model_ka = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', 
                                motorization: '1.0', car_category: car_category_a,
                                fuel_type: 'Flex')

    model_fusion = CarModel.create!(name: 'Fusion Hybrid', year: 2020, manufacturer: 'Ford', 
                                motorization: '2.2', car_category: car_category_a,
                                fuel_type: 'Elétrico')
                                
    subsidiary = Subsidiary.create!(name: 'Unidas', cnpj: '63.463.524/0001-39',
                                address: 'Rua Santiago')

    car = Car.create!(license_plate: 'ABC123', color: 'Prata',
                      car_model: model_ka, mileage: 10, subsidiary: subsidiary, status: :available)

    another_car = Car.create!(license_plate: 'VCD1234', color: 'Prata',
                              car_model: model_ka, mileage: 10, subsidiary: subsidiary, status: :rented)

    car_fusion = Car.create!(license_plate: 'XYZ9876', color: 'Azul',
                      car_model: model_fusion, mileage: 10, subsidiary: subsidiary, status: :rented)

    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                            client: client, car_category: car_category_a,
                            user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Iniciar locação'

    expect(page).to have_content(car.license_plate)
    expect(page).not_to have_content(another_car.license_plate)
    expect(page).not_to have_content(car_fusion.license_plate)
  end
end