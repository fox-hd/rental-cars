require 'rails_helper'

feature 'admin register client' do
  scenario 'successfully' do
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar novo cliente'
    fill_in 'Nome', with: 'Fulano Sicrano'
    fill_in 'CPF', with: '512.129.580-47'
    fill_in 'email', with: 'client@test.com'
    click_on 'Cadastrar'

    expect(page).to have_content('Fulano Sicrano')
    expect(page).to have_content('512.129.580-47')
    expect(page).to have_content('client@test.com')
  end

  scenario 'must fill all fields' do
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

  scenario 'and cpf must be valid' do
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar novo cliente'
    fill_in 'Nome', with: 'Fulano Sicrano'
    fill_in 'CPF', with: '512.129.580-44'
    fill_in 'email', with: 'client@test.com'
    click_on 'Cadastrar'

    expect(page).to have_content('não é válido')
  end
end