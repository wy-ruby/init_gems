Rails.application.config.session_store :redis_store,
                                       servers: REDIS_CONFIG.merge({namespace: 'session'}),
                                       expire_after: 90.minutes,
                                       key: "#{Rails.application.class.parent_name.downcase}_session_#{Time.now.to_i}",
                                       threadsafe: false
