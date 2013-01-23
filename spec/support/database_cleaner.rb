DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|

  config.before :suite do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  config.after :suite do
    DatabaseCleaner.clean
  end
end

