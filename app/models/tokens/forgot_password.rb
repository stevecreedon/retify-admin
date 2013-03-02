module Tokens
  class ForgotPassword < Tokens::Base
    
    before_create :set_valid_until

    scope :valid, lambda{|guid| Tokens::ForgotPassword.where("guid = ? AND valid_until > ?", guid, Time.now)} 

    private

    def set_valid_until
     self.valid_until = Time.now + 24.hours;
    end

  end
end
