class FactureMailer < ApplicationMailer

  def validation_complete(facture)
    @facture = facture
    @url  = 'http://www.gmail.com'
    mail(to: 'haniamiine@gmail.com', subject: 'Facture Validé')
  end
end
