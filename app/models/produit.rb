class Produit < ApplicationRecord
  require 'csv'

  validates :libelle, length: { maximum: 255 }

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Produit.create! row.to_hash
    end
  end

end
