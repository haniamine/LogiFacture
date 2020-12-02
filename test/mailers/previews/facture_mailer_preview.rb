# Preview all emails at http://localhost:3000/rails/mailers/facture_mailer
class FactureMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/facture_mailer/validation_complete
  def validation_complete
    FactureMailer.validation_complete
  end

end
