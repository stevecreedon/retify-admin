# == Schema Information
#
# Table name: identities
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  provider        :string(255)
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  state           :string(255)
#  type            :string(255)
#

class PasswordIdentity < Identity
  include ActiveModel::Transitions

  has_secure_password

  attr_accessor :confirm, :updating_password
  attr_accessible :password, :confirm, :email 

  has_one :validate_email_token, :class_name => Tokens::ValidateEmail, :dependent => :destroy

  PROVIDER = 'password' 

  after_create Proc.new{|model| model.require_verification!}

  validates_with Validators::Password, :if => Proc.new{|model| model.updating_password}

  state_machine do
    state :new # first one is initial state
    state :verifying
    state :verified

    event :require_verification, :success => :send_verification_email do
      transitions :to => :verifying, :from => :new
    end

    event :verify do
      transitions :to => :verified, :from => [:new, :verifying]
    end
  end

  def self.create_from_auth(auth)
    PasswordIdentity.create do |identity|
      identity.provider =  auth["provider"],
      identity.password_digest = auth["uid"],
      identity.name = auth["info"]["name"], #this can be email for some providers like omniauth-password
      identity.email = auth["info"]["email"] #email not required in oauth spec. Twitter, for example, doesn't provide email
    end
  end


private

  def send_verification_email
    Verifier.verify(self).deliver
  end

end
