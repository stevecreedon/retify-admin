class Identity < ActiveRecord::Base
  include ActiveModel::Transitions

  has_secure_password

  attr_accessor :confirm
  attr_accessible :password, :provider, :name, :email, :confirm

  validates :provider, :presence => true
  validates :password_digest, :presence => true
  validate :validate_password, :if => Proc.new{|identity| identity.rentified?}

  belongs_to :user

  scope :rentified, lambda{where(:provider => "password")}

  after_create Proc.new{|identity| identity.require_verification! if identity.rentified?}

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

  private

  def validate_password

    if password.blank?
      errors.add(:password, 'no password provided')
      return  
    end
 
    unless password =~ /^[A-Za-z0-9]*$/
      errors.add(:password, 'password must contain only characters or numbers')
    end

    if password.size < 6
      errors.add(:password, 'password must be at least 6 characters long')
    end

    if password != confirm
      errors.add(:password, 'password and confirm password do not match')
    end

  end

  def send_verification_email
     mail = Verifier.verify(self.user)
     mail.deliver 
  end

end
