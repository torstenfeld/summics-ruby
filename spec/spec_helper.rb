$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'summics'
gem 'minitest'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
# require 'turn'
#
# Turn.config do |c|
#  # :outline  - turn's original case/test outline mode [default]
#  c.format  = :outline
#  # turn on invoke/execute tracing, enable full backtrace
#  c.trace   = true
#  # use humanized test names (works only with :outline format)
#  c.natural = true
# end

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures"
  c.hook_into :webmock
end
