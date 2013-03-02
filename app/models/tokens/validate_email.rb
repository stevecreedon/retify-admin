module Tokens
  class ValidateEmail < Tokens::Base

    scope :validate_email, lambda{where(:type => "ValidateEmail")}


  end
end
