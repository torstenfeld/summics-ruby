require_relative 'spec_helper'
require_relative '../lib/summics'

describe Summics do
  it 'has a version number' do
    Summics::VERSION.wont_be_nil
  end
end

describe 'Summics Methods' do
  let(:client) { Summics::Client.new('asdf', 'asdf') }

  describe 'get projects' do
    # let(:client) { Summics::Client.new('asdf', 'asdf') }

    before do
      VCR.insert_cassette 'projects', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it 'must have a projects method' do
      client.must_respond_to :projects
    end

    it 'must parse the projects api response from JSON to Hash' do
      client.projects.must_be_instance_of Array
    end
  end

  # TODO: add test for topics
  describe 'get topics' do
    # let(:client) { Summics::Client.new('asdf', 'asdf') }

    before do
      VCR.insert_cassette 'projects', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end
  end


  # TODO: add test for topicsOverview
  # TODO: add test for texts with topics
  # TODO: add test for texts without topics
  # TODO: add test for dashboard
  # TODO: add test for addTexts
  # TODO: add test for text with textid
  # TODO: add test for text with source and postid
end

