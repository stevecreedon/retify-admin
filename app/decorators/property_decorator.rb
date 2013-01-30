class PropertyDecorator < ApplicationDecorator
  delegate_all
  decorates_association :address
end
