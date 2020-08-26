require 'rails_helper'

RSpec.describe Client, type: :model do
  context 'validation' do
    it 'attirbutes cannot be blank' do
      client = Client.new

      client.valid?

      expect(client.errors[:name]).to include('não pode ficar em branco')
      expect(client.errors[:cpf]).to include('não pode ficar em branco')
      expect(client.errors[:email]).to include('não pode ficar em branco')
    end

    it 'cpf must be unique' do 
      Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-47', email: 'client@test.com')
      client = Client.new(cpf: '512.129.580-47')

      client.valid?

      expect(client.errors[:cpf]).to include('já está em uso')
    end
  end
end
