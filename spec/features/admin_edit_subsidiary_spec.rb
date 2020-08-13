require 'rails_helper'

feature 'Admin edits data subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Campus Code', cnpj: '03.791.144/0001-00',
                       address: 'Av')

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
    Subsidiary.create!(name: 'Campus Code', cnpj: '03.791.144/0001-00',
                       address: 'Av Paulista')
    Subsidiary.create!(name: 'Family Code', cnpj: '03.791.144/0001-02',
                       address: 'Av Consolação')

    visit root_path
    click_on 'Filiais'
    click_on 'Campus Code'
    click_on 'Editar'
    fill_in 'Nome', with: 'family Code'
    fill_in 'CNPJ', with: '03.791.144/0001-02'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso', count: 2)
  end
end
