class Identity < ActiveRecord::Base
  include ActiveModel::Transitions

  has_secure_password

  attr_accessible :password, :provider, :name, :email

  validates :provider, :presence => true
  validates :email, :presence => true

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

  def send_verification_email
     mail = Verifier.verify(self.user)
     mail.deliver 
  end

end
