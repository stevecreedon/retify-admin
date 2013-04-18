class Api::FeedsController < ApiController
  def index

# feed has handler that is simple unique string
# priority, feeds are sorted by priority
# status could be skiped, active, done, later

    feeds = []
    if current_user.sites.count == 0
      feeds << {
        id:        1,
        template:  '/assets/views/feeds/site.html',
        title:     'Create your Holiday Rental website',
        icon:      'icon-globe',
        status:    'active',
        priority:  5
      }
    end
    if current_user.properties.count == 0
      feeds << {
        id:       2,
        template: '/assets/views/feeds/property.html',
        title:    'Create your property',
        icon:     'icon-eye-open',
        status:   'active',
        priority: 5
      }
    else
      property = current_user.properties.first
      if property.calendars.count == 0
        feeds << {
          id:       3,
          template:  '/assets/views/feeds/property/calendar.html',
          title:     'Add Calendar to the property',
          icon:      'icon-globe',
          parent_id: 9,
          status:    'active',
          priority:  5
        }
      end
      if property.photos.count == 0
        feeds << {
          id:        4,
          template:  '/assets/views/feeds/property/photo.html',
          title:     'Add Photo to the property',
          icon:      'icon-globe',
          parent_id: 9,
          status:    'active',
          priority:  5
        }
      end
      if property.directions.count == 0
        feeds << {
          id:        5,
          template:  '/assets/views/feeds/property/direction.html',
          title:     'Add Direction to the property',
          icon:      'icon-globe',
          parent_id: 9,
          status:    'active',
          priority:  5
        }
      end
      if property.articles.count == 0
        feeds << {
          id:        6,
          template:  '/assets/views/feeds/property/article.html',
          title:     'Add Article to the property',
          icon:      'icon-globe',
          parent_id: 9,
          status:    'active',
          priority:  5
        }
      end
    end

    render json: feeds
  end

  def destroy

  end
end
