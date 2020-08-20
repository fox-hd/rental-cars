require 'rails_helper'

feature 'Admin edits data subsidiary' do
  scenario 'must be sign in' do
    
    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    Subsidiary.create!(name: 'Campus Code', cnpj: '03.791.144/0001-00',
                       address: 'Av')
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Campus Code'
    click_on 'Editar'
    fill_in 'Nome', with: 'Family Code'
    fill_in 'CNPJ', with: '87.760.628/0001-73'
    fill_in 'Endereço', with: 'Av Consolação'
    click_on 'Enviar'

    expect(page). to have_content('Family Code')
    expect(page).not_to have_content('Campus Code')
    expect(page).to have_content('87.760.628/0001-73')
    expect(page).to have_content('Av Consolação')
  end

  scenario 'attributes cannot be blank' do
    Subsidiary.create!(name: 'Campus Code', cnpj: '03.791.144/0001-00',
                       address: 'Av')
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Campus Code'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'name and cnpj must be uniq' do
    Subsidiary.create!(name: 'Campus Code', cnpj: '73.040.360/0001-90',
                       address: 'Av Paulista')
    Subsidiary.create!(name: 'Family Code', cnpj: '63.463.524/0001-39',
                       address: 'Av Consolação')
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Campus Code'
    click_on 'Editar'
    fill_in 'Nome', with: 'family Code'
    fill_in 'CNPJ', with: '63.463.524/0001-39'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso', count: 2)
  end
end
