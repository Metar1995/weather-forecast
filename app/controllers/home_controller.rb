class HomeController < ApplicationController
  def postcode_wise_weather
    require 'net/http'
    require 'json'
    postcode = params[:postcode_params]
    pc = UKPostcode.parse(postcode)
    if pc.valid?
      @url = 'https://api.weatherapi.com/v1/forecast.json?key=55b7fdf17805493199a143223212409&q='+ postcode +'&forecast_days=1&hourly=1'
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)
      @final_result = @output["forecast"]["forecastday"][0]["day"]["maxtemp_c"]
      if @final_result <= 15
        render json: {message: "Its Cold Today with max temperature #{@final_result} Degree Celcius"}
      elsif @final_result >15 && @final_result <=25
        render json: {message: "Its Warm today with max temperature #{@final_result} Degree Celcius"}
      else
        render json: {message: "Its Hot today with max temperature #{@final_result} Degree Celcius"}
      end
    else
      render json: {error:{ code: 1006, message: "No matching location found."} }, status: :not_found
    end
  end
end
