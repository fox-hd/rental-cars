require 'rails_helper'

feature 'admin delte subsidiary' do
  scenario 'must be sign in' do
    
    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    Subsidiary.create!(name: 'Campus code', cnpj: '63.463.524/0001-39',
                         address: 'Rua Santiago')
    Subsidiary.create!(name: 'Treinadev', cnpj: '50.668.157/0001-68',
                       address: 'Av. Paulista')
    
    user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', password: '123456')
                    
    login_as(user, scope: :user)

    visit root_path
    click_on 'Filiais'
    click_on 'Campus code'
    click_on 'Apagar'

    expect(page).to have_content('Treinadev')
    expect(page).not_to have_content('Campus code')

  end
end