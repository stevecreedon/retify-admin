class ContactUs < MailForm::Base
  attribute :name,    validate: true, message: 'The Name can\'t be blank.'
  attribute :email,   validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i,
                      message: 'The Email Address you entered does not appear to be valid.'
  attribute :subject, validate: true, message: 'The Subject can\'t be blank.'
  attribute :message, validate: true, message: 'The Message can\'t be blank.'
  attribute :send_to

  # Declare the e-mail headers. It accepts anything the mail method in ActionMailer accepts.
  def headers
    {
      subject: subject,
      to:      send_to,
      from:    %("#{name}" <#{email}>)
    }
  end
end

