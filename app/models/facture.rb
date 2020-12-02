class Facture < ApplicationRecord
  belongs_to :client
  belongs_to :user

  def self.idd

  end

  scope :osearch, lambda { |search|
    cols = Facture.column_names.reject{ |col| col == 'created_at' || col == 'updated_at'}
    resp = ''
    cols.each do |col|
      resp += "#{col} like '%#{search}%' or "
    end

    where(resp[0..(resp.length - 4)])
  }

  scope :search, ->(search) { where("#{column_names.reject{ |col| col == 'created_at' || col == 'updated_at'}.join(" like '%#{search}%' or ")} like ?", "%#{search}%")}

  #scope :group_by_month,   -> { group("date_trunc('month', created_at) ") }


end
