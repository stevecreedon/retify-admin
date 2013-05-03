class Api::RegistrationController < ApiController
  def send_again
    current_user.password_identity.send_verification_email if current_user.password_identity
    render json: {}, status: status
  end
end
