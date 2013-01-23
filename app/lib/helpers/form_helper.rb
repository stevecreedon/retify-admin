class FormHelper < ActionView::Base
  include ActionView::Helpers::TagHelper

  def help_block(text)
    content_tag(:p, class: 'help-block') do
      text
    end
  end

  def error_class(field, model)
    'error' if has_error?(field, model)
  end

  def error_message(field, model)
    if has_error?(field, model)
      content_tag(:span, class: 'help-inline') do
        if model.errors[field].kind_of? Array
          model.errors[field].map do | message |
            model.errors.full_message(field, message)
          end.join('. ')
        else
          model.errors.full_message(field, model.errors[field])
        end
      end
    end
  end

private

  def has_error?(field, model)
    model.errors.any? && !model.errors[field].blank?
  end
end
