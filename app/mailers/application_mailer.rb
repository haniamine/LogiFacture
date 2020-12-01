class ApplicationMailer < ActionMailer::Base
  default from: 'testlogimail@gmail.com'
  layout 'mailer'

  def validated_facture(facture)
    @facture = facture
    @url  = 'http://www.gmail.com'
    mail(to: 'haniamiine@gmail.com', subject: 'Facture Validé')
  end

end
