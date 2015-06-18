require_relative 'spec_helper'

describe Summics do
  it 'has a version number' do
    expect(Summics::VERSION).not_to be nil
  end

  # it 'does something useful' do
  #   expect(false).to eq(true)
  # end
end

class SummicsClientTest < Minitest::Test
  def test_exists
    assert Summics::Client
  end
end