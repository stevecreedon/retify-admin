class MockIdentity < Identity
  PROVIDER = 'twaddle'
  before_validation Proc.new{|model| model.password_digest = '12345678920'}
end

