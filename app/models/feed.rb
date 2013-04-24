class Feed < ActiveRecord::Base
  attr_accessible :icon, :template, :title, :parent_id, :user_id, :user, :feed_type

  belongs_to :user

  validates :feed_type, presence: true
  validates :template,  presence: true, unless: 'new_record?'
  validates :icon,      presence: true, unless: 'new_record?'
  validates :title,     presence: true, unless: 'new_record?'
  validates :user,      presence: true

  before_create do
    self.icon     = 'icon-globe'

    case self.feed_type
    when :create_site
      self.template = '/assets/views/feeds/site.html'
      self.title    = 'Create your Holiday Rental website'
    when :create_property
      self.template = '/assets/views/feeds/property.html'
      self.title    = 'Create your property'
      self.icon     = 'icon-eye-open'
    when :create_property_calendar
      self.template = '/assets/views/feeds/property/calendar.html'
      self.title    = 'Add Calendar to the property'
    when :create_property_photos
      self.template = '/assets/views/feeds/property/photo.html'
      self.title    = 'Add Photo to the property'
    when :create_property_directions
      self.template = '/assets/views/feeds/property/direction.html'
      self.title    = 'Add Direction to the property'
    when :create_property_terms_page
      self.template = '/assets/views/feeds/property/pages/terms.html'
      self.title    = 'Add Terms and Conditions'
    when :create_property_availability_page
      self.template = '/assets/views/feeds/property/pages/availability.html'
      self.title    = 'Add Availability data'
    end
  end
end
