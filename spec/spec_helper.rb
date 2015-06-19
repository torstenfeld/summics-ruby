$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require_relative '../lib/summics'
gem 'minitest'
require 'minitest/autorun'
# require 'minitest/documentation'  # https://github.com/teoljungberg/minitest-documentation
# require 'minispec-metadata'  # https://github.com/ordinaryzelig/minispec-metadata
# require 'minitest-spec-context'  # https://github.com/ywen/minitest-spec-context
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures'
  c.hook_into :webmock
end
