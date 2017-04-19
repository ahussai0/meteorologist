require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    @street_address.gsub(" ", "+")
    url1 = "http://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address
    parsed_data = JSON.parse(open(url1).read)
    lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    lng = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url2 = "https://api.darksky.net/forecast/c278b1f4cf22a20f96b85450c1c72df8/" + lat.to_s + "," + lng.to_s
    parsed_data = JSON.parse(open(url2).read)
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





    render("meteorologist/street_to_weather.html.erb")
  end
end
