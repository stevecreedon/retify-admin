class CalendarsController < ApplicationController
  before_filter :load_property
  before_filter :check_if_property_belongs_to_user

  def index
    if calendar = @property.calendars.first
      redirect_to property_calendar_path(@property, calendar) 
    else
      redirect_to new_property_calendar_path(@property)
    end
  end

  def show
    @calendar = @property.calendars.where(id: params[:id]).first
    redirect_to action: :new unless @calendar
  end

  def new
    redirect_to action: :index if @property.calendars.count > 0

    @calendar = Calendar.new property: @property
  end

  def create
    redirect_to action: :index if @property.calendars.count > 0

    @calendar = Calendar.new params[:calendar].merge(property: @property)
    @calendar.enabled = true

    if @calendar.save
      redirect_to(property_calendar_path(@property, @calendar), notice: 'Calendar was successfully created.')
    else
      render :action => "new"
    end
  end

  def edit
    @calendar = @property.calendars.where(id: params[:id]).first
  end

  def update
    @calendar = @property.calendars.where(id: params[:id]).first

    if @calendar.update_attributes(params[:calendar].merge(property: @property))
      redirect_to(property_calendar_path(@property, @calendar), notice: 'Calendar was successfully updated.')
    else
      render :action => "edit"
    end
  end

private

  def load_property
    @property = Property.find(params[:property_id])
  end

  def check_if_property_belongs_to_user
    if @property.user != current_user
      redirect_to root_path
    end
  end
end
