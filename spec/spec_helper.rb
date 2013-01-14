require 'rubygems'
require 'bundler/setup'

require 'bamboo_api'
require "multi_json"
require 'webmock/rspec'
require 'vcr'

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.default_cassette_options = { record: :once, serialize_with: :json, preserve_exact_body_bytes: true, decode_compressed_response: true }
  c.hook_into :webmock
end