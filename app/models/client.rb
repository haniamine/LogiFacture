class Client < ApplicationRecord
  has_many :facture

  validates :nom, length: { maximum: 255 }
  validates :email, uniqueness: true
end
