$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require_relative '../lib/summics'
gem 'minitest'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures'
  c.hook_into :webmock
end
