require 'rails_helper'

describe Subsidiary, type: :model do
  context 'validation' do
    it 'attributes cannot blank' do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('não pode ficar em branco')
      expect(subsidiary.errors[:cnpj]).to include('não pode ficar em branco')
      expect(subsidiary.errors[:address]).to include('não pode ficar em branco')
    end

    it 'name and cnpj must be uniqu' do
      Subsidiary.create(name: 'Campus code', cnpj: '73040360000190', address: 'Alameda Santos')
      subsidiary = Subsidiary.new(name: 'Campus code', cnpj: '73040360000190', address: 'Rua consolação')

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('já está em uso')
      expect(subsidiary.errors[:cnpj]).to include('já está em uso')
    end

    it 'name uniqueness is not case sensitive' do
      Subsidiary.create(name: 'Campus code', cnpj: '73040360000190', address: 'Alameda Santos')
      subsidiary = Subsidiary.new(name: 'campus code', cnpj: '73040360000190', address: 'Rua consolação')

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('já está em uso')
    
    end


  end

end