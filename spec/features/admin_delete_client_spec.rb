require 'rails_helper'

feature 'admin delele client' do

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
    click_on 'Fulano Sicrano'
    click_on 'Apagar'

    expect(page).not_to have_content('Fula Sicrano')
  end
end