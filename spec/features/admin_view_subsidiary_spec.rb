require 'rails_helper'

  feature 'Admin view subsidiaries' do
    scenario 'sucessfully' do
      Subsidiary.create!(name: 'Campus code', cnpj: '222333333-98',
                         address: 'Rua Santiago')
      Subsidiary.create!(name: 'Treinadev', cnpj: '333222222-99',
                         address: 'Av. Paulista')

      visit root_path
      click_on 'Filiais'

      expect(current_path).to eq subsidiaries_path
      expect(page).to have_content('Campus code')
      expect(page).to have_content('Treinadev')
    end

    scenario 'and no one subsidiary are created' do
      
      visit root_path
      click_on 'Filiais'

      expect(page).to have_content('Nenhuma Filial cadastrada')
    end

    scenario 'and view details' do
      Subsidiary.create!(name: 'Campus code', cnpj: '222333333-98',
                         address: 'Rua Santiago')

      visit root_path
      click_on 'Filiais'
      click_on 'Campus code'

      expect(page).to have_content('222333333-98')
      expect(page).to have_content('Rua Santiago')
    end

    scenario 'and return to home page' do
      Subsidiary.create!(name: 'Campus code', cnpj: '222333333-98',
                         address: 'Rua Santiago')

      visit root_path
      click_on 'Filiais'
      click_on 'Voltar'

      expect(current_path).to eq root_path
    end

    scenario 'and return to subsidiaries page' do
      Subsidiary.create!(name: 'Campus code', cnpj: '222333333-98',
                         address: 'Rua Santiago')

      visit root_path
      click_on 'Filiais'
      click_on 'Campus code'
      click_on 'Voltar'

      expect(current_path).to eq subsidiaries_path
    end
  end
