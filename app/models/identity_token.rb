class IdentityToken < ActiveRecord::Base
  belongs_to :user

  attr_accessible :purpose

  validates :purpose, :presence => true, inclusion: {in: %{validate_email, reset_password}}

  before_create :set_guid, :set_valid_until 

  scope :validate_email, lambda{where(:purpose => "validate_email")}
 

  def to_param
    guid
  end

  private

  def set_guid
    self.guid = SecureRandom.urlsafe_base64;
  end
 
  def set_valid_until
    self.valid_until = Time.now + 24.hours if self.purpose == 'reset_password';
  end

end
