require 'rails_helper'

feature 'Admin view list of client registered' do
  scenario 'must be sign in' do
    
    visit root_path
    click_on 'Modelos de carro'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-47', email: 'client@test.com')
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('Fulano Sicrano')
    expect(page).to have_content('512.129.580-47')
    expect(page).to have_content('client@test.com')
  end

  scenario 'and nothing is registered' do 
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('Nenhum cliente cadastrado')
  end
end