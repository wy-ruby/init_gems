Rails.application.config.session_store :redis_store,
                                       servers: CACHE_REDIS_CONFIG.merge({namespace: 'session', expires_in: 1.minutes}),
                                       expire_after: 90.minutes,
                                       key: "#{Rails.application.class.parent_name.downcase}_session_#{Time.now.to_i}",
                                       threadsafe: false
