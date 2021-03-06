require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'must be sign in' do


    visit root_path
    click_on 'Categorias'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se')
  end

  scenario 'from index page' do
    user = User.create!(name: 'João Almeida', email:'joao@gmail.com', password:'123456')

    login_as(user, :scope => :user)

    visit root_path
    click_on 'Categorias'

    expect(page).to have_link('Registrar uma nova categoria',
                              href: new_car_category_path)
  end

  scenario 'successfully' do
    user = User.create!(name: 'João Almeida', email:'joao@gmail.com', password:'123456')

    login_as(user, :scope => :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'

    fill_in 'Nome', with: 'Top'
    fill_in 'Diária', with: '100'
    fill_in 'Seguro do carro', with: '50'
    fill_in 'Seguro para terceiros', with: '10'
    click_on 'Enviar'

    expect(current_path).to eq car_category_path(CarCategory.last)
    expect(page).to have_content('Top')
    expect(page).to have_content('R$ 100,00')
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_link('Voltar')
  end

  scenario 'and price must be greater than zero' do
    user = create(:user)
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'
    fill_in 'Nome', with: 'Flex'
    fill_in 'Diária', with: '0'
    fill_in 'Seguro do carro', with: '0'
    fill_in 'Seguro para terceiros', with: '0'
    click_on 'Enviar'

    expect(page).to have_content('deve ser maior que 0', count:3)
  end
end
