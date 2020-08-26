require 'rails_helper'

feature 'admin search client' do
  scenario 'must be sign in' do
    
    visit root_path
    click_on 'Clientes'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se')
  end


  scenario 'from index page' do
    user = User.create!(name: 'João Almeida', email:'joao@gmail.com', password:'123456')

    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'

    expect(current_path).to eq clients_path
  end

  scenario 'and find exact match' do
    client = Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-47', 
                            email: 'test@client.com')
    user = User.create!(name: 'Lorem Upsum', email: 'lorem@ipsum.com',
                        password: '12345678')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    fill_in 'Buscar nome do cliente', with: 'Fulano Sicrano'
    click_on 'Buscar'

    expect(page).to have_content('Fulano Sicrano')
  end

  scenario 'and find partial match' do
    client = Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-47', 
                            email: 'test@client.com')
    user = User.create!(name: 'Lorem Upsum', email: 'lorem@ipsum.com',
                        password: '12345678')
  
    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    fill_in 'Buscar nome do cliente', with: 'Fulano'
    click_on 'Buscar'
  
    expect(page).to have_content('Fulano Sicrano')
  end
end