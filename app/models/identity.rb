class Identity < ActiveRecord::Base
  include ActiveModel::Transitions
 
  belongs_to :user

  before_validation Proc.new{|model| model.provider = self.class::PROVIDER}
 
  
end
