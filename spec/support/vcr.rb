require 'vcr'

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

aws_uri_matcher = VCR
  .request_matchers
  .uri_without_params 'Timestamp',
                      'AWSAccessKeyId',
                      'AssociateTag',
                      'Signature'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures'
  c.configure_rspec_metadata!
  c.default_cassette_options = { record:            :new_episodes,
                                 match_requests_on: [aws_uri_matcher] }
  c.hook_into :excon
end
