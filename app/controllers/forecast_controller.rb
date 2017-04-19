require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================
    url = "https://api.darksky.net/forecast/c278b1f4cf22a20f96b85450c1c72df8/" + @lat + "," + @lng
    parsed_data = JSON.parse(open(url).read)
    #lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    #long = parsed_data["results"][0]["geometry"]["location"]["lng"]
    currentTemp = parsed_data["currently"]["temperature"]
    currentSummary = parsed_data["currently"]["summary"]
    nextSixty = parsed_data["minutely"]["summary"]
    nextHours = parsed_data["hourly"]["summary"]
    nextDays = parsed_data["daily"]["summary"]

    @current_temperature = currentTemp

    @current_summary = currentSummary

    @summary_of_next_sixty_minutes = nextSixty

    @summary_of_next_several_hours = nextHours

    @summary_of_next_several_days = nextDays

    render("forecast/coords_to_weather.html.erb")
  end
end
