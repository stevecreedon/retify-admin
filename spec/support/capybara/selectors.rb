# coding: utf-8
module MyHelpers
  module SelectorHelpers
    def within_table_row(text, &block)
      if block_given?
        within(:xpath, "//td[contains(text(),'#{text}')]/..") do
          yield
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include MyHelpers::SelectorHelpers, :type => :feature
end

