class Capybara::Selenium::Node
  def set(value)
    tag_name = self.tag_name
    type = self[:type]
    if (Array === value) && !self[:multiple]
      raise ArgumentError.new "Value cannot be an Array when 'multiple' attribute is not present. Not a #{value.class}"
    end
    if tag_name == 'input' and type == 'radio'
      click
    elsif tag_name == 'input' and type == 'checkbox'
      click if value ^ native.attribute('checked').to_s.eql?("true")
    elsif tag_name == 'input' and type == 'file'
      path_names = value.to_s.empty? ? [] : value
      native.send_keys(*path_names)
    elsif tag_name == 'textarea' or tag_name == 'input'
      #script can change a readonly element which user input cannot, so dont execute if readonly
      driver.browser.execute_script "arguments[0].value = 'x'", native unless self[:readonly]
      native.send_keys(:backspace)
      native.send_keys(value.to_s)
    end
  end
end
