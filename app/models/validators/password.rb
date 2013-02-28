module Validators
 class Password < ActiveModel::Validator 
     
   def validate(record)

    if record.password.blank?
      record.errors.add(:password, 'not provided')
      return  
    end
 
    unless record.password =~ /^[A-Za-z0-9]*$/
      record.errors.add(:password, 'must contain only characters or numbers')
    end

    if record.password.size < 6
      record.errors.add(:password, 'must be at least 6 characters long')
    end

    if record.password != record.confirm
      record.errors.add(:password, 'and Password Confirmation do not match')
    end

  end

 end
end
