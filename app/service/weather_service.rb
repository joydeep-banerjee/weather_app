# This is a service class to get data from weather API using zip code
class WeatherService
  
  API_KEY = CONFIG['forecast_api_key'] ## The original API key has been provided in an email.

	def initialize(zipcode)
		@zip_code = zipcode
	end

	def get_forecast
		uri = URI("https://api.openweathermap.org/data/2.5/weather?zip=#{@zip_code}&appid=#{API_KEY}")
		# uri = URI("https://api.openweathermap.org/data/2.5/weather?q=#{city_name}&appid=#{API_KEY}")
    response = HTTParty.get(uri, headers: { 'Content-Type' => 'application/json' })
	end
end