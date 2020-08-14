require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'from index page' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar uma nova filial', 
                              href: new_subsidiary_path)
  end

  scenario 'sucessfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'

    fill_in 'Nome', with: 'Campus code'
    fill_in 'CNPJ', with: '63.463.524/0001-39'
    fill_in 'Endereço', with: 'Av. Paulista, 88'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content('Campus code')
    expect(page).to have_content('63.463.524/0001-39')
    expect(page).to have_content('Av. Paulista, 88')
    expect(page).to have_link('Voltar')
  end
end