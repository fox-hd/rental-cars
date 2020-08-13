class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: :true
  validates :name, :cnpj, uniqueness: {case_sensitive: false }
end
