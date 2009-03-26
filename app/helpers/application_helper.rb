# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  T = Time.now

def time_24_hour
  T.strftime("%H:%M")
end

def full_date
  Date.today.to_s(:long)
end

def simple_date_and_time
  T.to_s(:short)
end

def chatty_time_and_date
  "It's " + time_24_hour + " on " + full_date
end

end
