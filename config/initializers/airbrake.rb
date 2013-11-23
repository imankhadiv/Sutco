Airbrake.configure do |config|
  config.api_key = 'acd91848dd09e9d9f95ee24f8d4a0064'
  config.host    = 'errbit.genesys-solutions.org.uk'
  config.port    = 443
  config.secure  = config.port == 443
end
