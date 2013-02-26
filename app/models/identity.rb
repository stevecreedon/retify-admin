class Identity < ActiveRecord::Base
  include ActiveModel::Transitions

  has_secure_password

  attr_accessible :provider, :name, :email, :password

  validates :provider, :presence => true
  validates :password_digest, :presence => true
  validates_with PasswordValidator, :if => lambda{|model| model.is_a?(PasswordIdentity)} 
 
  belongs_to :user

  scope :rentified, lambda{where(:provider => "password")}

  after_create Proc.new{|model| model.require_verification! if model.rentified?}

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

  def rentified?
    provider == 'password'
  end

  
  def send_verification_email
     mail = Verifier.verify(self.user)
     mail.deliver 
  end

end
