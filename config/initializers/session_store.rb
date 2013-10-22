# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
Rails4Sample::Application.config.session_store :active_record_store, :key => (
                                                                      Rails.env.production? ? '_Rails4Sample_session_id' : (
                                                                      Rails.env.demo? ? '_Rails4Sample_demo_session_id' : 
                                                                      '_Rails4Sample_dev_session_id'
                                                                    )),
                                                                    :secure => (Rails.env.demo? || Rails.env.production?), # Only send cookie over SSL when deployed
                                                                    :httponly => true, # Don't allow Javascript to access the cookie (mitigates cookie-based XSS exploits)
                                                                    :expire_after => 30.minutes # This may need changing on a per-app basis