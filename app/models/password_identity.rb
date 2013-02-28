class PasswordIdentity < Identity
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
     mail = Verifier.verify(self.user)
     mail.deliver 
  end

end
