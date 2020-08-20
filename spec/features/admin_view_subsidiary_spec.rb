require 'rails_helper'

  feature 'Admin view subsidiaries' do
    scenario 'must be sign in' do
    
      visit root_path
      click_on 'Filiais'
  
      expect(current_path).to eq new_user_session_path
    end

    scenario 'sucessfully' do
      Subsidiary.create!(name: 'Campus code', cnpj: '63.463.524/0001-39',
                         address: 'Rua Santiago')
      Subsidiary.create!(name: 'Treinadev', cnpj: '50.668.157/0001-68',
                         address: 'Av. Paulista')
      user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

      login_as(user, scope: :user)
      visit root_path
      click_on 'Filiais'

      expect(current_path).to eq subsidiaries_path
      expect(page).to have_content('Campus code')
      expect(page).to have_content('Treinadev')
    end

    scenario 'and no one subsidiary are created' do

    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

    login_as(user, scope: :user)
      visit root_path
      click_on 'Filiais'

      expect(page).to have_content('Nenhuma Filial cadastrada')
    end

    scenario 'and view details' do
      Subsidiary.create!(name: 'Campus code', cnpj: '50.668.157/0001-68',
                         address: 'Rua Santiago')
      user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

      login_as(user, scope: :user)
      visit root_path
      click_on 'Filiais'
      click_on 'Campus code'

      expect(page).to have_content('50.668.157/0001-68')
      expect(page).to have_content('Rua Santiago')
    end

    scenario 'and return to home page' do
      Subsidiary.create!(name: 'Campus code', cnpj: '50.668.157/0001-68',
                         address: 'Rua Santiago')
      user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

      login_as(user, scope: :user)
      visit root_path
      click_on 'Filiais'
      click_on 'Voltar'

      expect(current_path).to eq root_path
    end

    scenario 'and return to subsidiaries page' do
      Subsidiary.create!(name: 'Campus code', cnpj: '50.668.157/0001-68',
                         address: 'Rua Santiago')
      user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')

      login_as(user, scope: :user)
      visit root_path
      click_on 'Filiais'
      click_on 'Campus code'
      click_on 'Voltar'

      expect(current_path).to eq subsidiaries_path
    end
  end
