class Identity < ActiveRecord::Base
  belongs_to :user

  before_validation Proc.new{|model| model.provider = self.class::PROVIDER}
end
