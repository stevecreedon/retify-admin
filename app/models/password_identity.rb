module PasswordIdentity

  def self.extended(base)
    attr_accessor :confirm
  end

end
