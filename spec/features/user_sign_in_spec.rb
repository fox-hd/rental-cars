require 'rails_helper'

feature 'user sign in' do
  scenario 'from home page' do

    visit root_path


    expect(page).to have_link('Entrar')
  end

  scenario 'successfully' do
    User.create!(name: 'João Almeida', email:'joao@gmail.com', password:'123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'joao@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    expect(page).to have_content('João Almeida')
    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')

  end
  scenario 'and sign out' do
    User.create!(name: 'João Almeida', email:'joao@gmail.com', password:'123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'joao@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Sair'

    expect(page).not_to have_content('João Almeida')
    expect(page).not_to have_content('Login efetuado com sucesso')
    expect(page).not_to have_link('Sair')
    expect(page).to have_link('Entrar')
  end
end