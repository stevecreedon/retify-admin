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

private

  def send_verification_email
    Verifier.verify(self.user).deliver
  end

end
