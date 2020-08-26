require 'rails_helper'

feature 'Admin edit client' do

  scenario 'mus be sign in' do
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
    click_on 'Editar'

    fill_in 'Nome', with: 'Mario Almeida'
    fill_in 'CPF', with: '920.636.490-14'
    fill_in 'email', with: 'test@teste.com'
    click_on 'Cadastrar'

    expect(page).to have_content('Mario Almeida')
    expect(page).to have_content('920.636.490-14')
    expect(page).to have_content('test@teste.com')
  end

  scenario 'and must fill all fields' do
    Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-47', email: 'client@test.com')
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar novo cliente'
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'email', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'and data must be unique' do
    Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-47', email: 'client@test.com')
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar novo cliente'
    fill_in 'Nome', with: 'Fulano Sicrano'
    fill_in 'CPF', with: '512.129.580-47'
    fill_in 'email', with: 'client@test.com'
    click_on 'Cadastrar'

    expect(page).to have_content('já está em uso')
  end
end