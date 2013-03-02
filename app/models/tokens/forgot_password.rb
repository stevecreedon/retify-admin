module Tokens
  class ForgotPassword < Tokens::Base
    
    before_create :set_valid_until 

    private

    def set_valid_until
     self.valid_until = Time.now + 24.hours;
    end

  end
end
