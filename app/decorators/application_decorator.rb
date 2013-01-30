class ApplicationDecorator < Draper::Decorator
  delegate_all

  def error_message(field)
    if has_error?(field)
      h.content_tag(:span, class: 'help-inline') do
        if source.errors[field].kind_of? Array
          source.errors[field].map do | message |
            source.errors.full_message(field, message)
          end.join('. ')
        else
          source.errors.full_message(field, source.errors[field])
        end
      end
    end
  end

  def has_error?(field)
    source.errors.any? && !source.errors[field].blank?
  end
end
