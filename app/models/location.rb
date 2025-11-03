class Location < ApplicationRecord
  
  # This method is use to get forecast details data
  # @param [String] loc input parameter
  # @return [Hash] returns hash
	def self.get_forecast_dtls(loc)
		return {"cod": "404", "message": "city not found"}.with_indifferent_access if loc.to_i == 0

		redis = RedisService.new(loc)
		redis_data = redis.get # fetch data from redis
    
		if redis_data.empty?
			forecast = WeatherService.new(loc)
			res = forecast.get_forecast

      return res if res["cod"] == "404"

			data = { "weather": { "main": res["weather"][0]["main"], "description": res["weather"][0]["description"] }, 
			"temperature": { "temp": res["main"]["temp"], "temp_min": res["main"]["temp_min"], "temp_max": res["main"]["temp_max"], "humidity": res["main"]["humidity"] },
		  "visibility": res["visibility"], "wind_speed": res["wind"]["speed"], "city": res["name"] }.with_indifferent_access

		  redis.set(data) # Set data to redis
		  data
		else
			redis_data
		end
	end
end