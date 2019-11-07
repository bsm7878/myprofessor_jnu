CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAJ2MBPC44SYFXJBNA',                        # required
    aws_secret_access_key: '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',                        # required
    region:                'ap-northeast-1'                  # optional, defaults to 'us-east-1'

  }
  config.fog_directory  = 'myprofessor'                          # required
  config.fog_public     = false                                        # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
end