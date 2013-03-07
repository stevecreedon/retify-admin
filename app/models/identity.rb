# == Schema Information
#
# Table name: identities
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  provider        :string(255)
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  state           :string(255)
#  type            :string(255)
#

class Identity < ActiveRecord::Base
  belongs_to :user

  before_validation Proc.new{|model| model.provider = self.class::PROVIDER}
end
