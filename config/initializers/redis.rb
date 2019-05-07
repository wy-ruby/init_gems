$redis = Redis.new(REDIS_CONFIG)

begin
  $redis.ping
rescue StandardError => e
  raise e.message
end