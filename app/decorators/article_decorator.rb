class ArticleDecorator < ApplicationDecorator
  delegate_all

  GROUPS = {
    terms:        'Terms and conditions',
    availability: 'Availabilities'
  }

  def group_list
    GROUPS.map{ | key, value | [ value, key ] }
  end

  def group_name
    GROUPS[source.group.to_sym]
  end
end
