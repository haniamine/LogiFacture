require 'test_helper'

class FactureMailerTest < ActionMailer::TestCase
  test "validation_complete" do
    mail = FactureMailer.validation_complete
    assert_equal "Validation complete", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
