# This is a service class to set and get data from redis
class RedisService

	def initialize(key)
		@key = key
		redis_client
	end

	def redis_client
    @redis_client = Redis.new(host: CONFIG['redis_host'], port: CONFIG['redis_port'].to_i, db: 0)
  end
  
  # Set method to set data in redis
  # It expiry time is set for 30 min i.e 1800 sec
  def set(val)
    redis_client.set(@key, val.to_json, ex: CONFIG['redis_expiry'].to_i)
  end
  
  # Get method to fetch data from redis
  def get
    JSON.parse(redis_client.get(@key) || '{}')
  end
end