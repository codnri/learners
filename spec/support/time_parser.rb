module TimeParser
  def timeParse(date_time)
    return date_time.in_time_zone('Eastern Time (US & Canada)').strftime("%d %b %Y %I:%M%p")
  end
end