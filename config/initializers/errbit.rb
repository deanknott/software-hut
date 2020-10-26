Airbrake.configure do |config|
  config.api_key = '09b605b1b84d70ae01da81316f5d7bde'
  config.host    = 'errbit.hut.shefcompsci.org.uk'
  config.port    = 443
  config.secure  = config.port == 443
end
