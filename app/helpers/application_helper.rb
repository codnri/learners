module ApplicationHelper
  def timeParse(date_time)
    return date_time.in_time_zone('Eastern Time (US & Canada)').strftime("%m/%d/%Y %I:%M%p")
  end
end
