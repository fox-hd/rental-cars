class Client < ApplicationRecord

  validates :name, :cpf, :email, presence:true
  validates :cpf, :email, uniqueness:true
  validate :cpf_valid

  def information
    "#{name} - #{cpf}"
  end

  def cpf_valid
    if cpf.present? && !CPF.valid?(cpf)
      errors.add(:cpf, 'não é válido')
    end
  end
end
