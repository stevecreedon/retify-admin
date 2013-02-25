class PasswordValidator < ActiveModel::Validator 
     
   def validate(record)

    raise "cannot validate password for non-password provider" unless record.rentified?

    if record.password.blank?
      record.errors.add(:password, 'no password provided')
      return  
    end
 
    unless record.password =~ /^[A-Za-z0-9]*$/
      record.errors.add(:password, 'password must contain only characters or numbers')
    end

    if record.password.size < 6
      record.errors.add(:password, 'password must be at least 6 characters long')
    end

    if record.password != record.confirm
      record.errors.add(:password, 'password and confirm password do not match')
    end

  end
  
end
