require 'rails_helper'

feature 'Admin register valid subsidiary' do
  scenario 'and name and cnpj must be unique' do
    Subsidiary.create!(name: 'Campus Code', cnpj: '03.791.144/0001-00',
                       address: 'Av Paulista')
    
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: 'campus code'
    fill_in 'CNPJ', with: '03.791.144/0001-00'
    fill_in 'Endereço', with: 'Alameda Santos'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso', count: 2)
  end

  scenario 'and name, cnpj and address cannot be blank ' do

    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
end