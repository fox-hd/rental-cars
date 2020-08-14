class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: :true
  validates :name, :cnpj, uniqueness: {case_sensitive: false }
  validate :cnpj_must_be_valid

  def cnpj_must_be_valid
    cnpj_digits = CNPJ.new(cnpj)
    if cnpj.present? && cnpj_digits.stripped.size != 14
      errors.add(:cnpj, 'deve ter 14 digitos')
    elsif cnpj.present? && !CNPJ.valid?(cnpj)
      errors.add(:cnpj, 'não é válido')
    else
    end
  end
  
end
