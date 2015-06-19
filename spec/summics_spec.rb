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

    before do
      VCR.insert_cassette 'projects', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it 'must have a projects method' do
      client.must_respond_to :projects
    end

    it 'must parse the projects api response from JSON to Array' do
      client.projects.must_be_instance_of Array
    end

    it 'must have at least one result' do
      client.projects.wont_be_empty
    end

    it 'must have one item with specific properties' do
      first_item = client.projects[0]
      first_item.must_be_instance_of Hash
      first_item.must_include 'id'
      first_item.must_include 'name'
      first_item.must_include 'sources'
    end

    describe 'sources' do
      let(:first_item) { client.projects[0] }
      it 'must have at least one item with specific properties' do
        first_item['sources'].must_be_instance_of Array
        source = first_item['sources'][0]
        source.must_include 'id'
        source.must_include 'name'
      end
    end
  end

  # TODO: add test for topics
  describe 'get topics' do

    before do
      VCR.insert_cassette 'topics', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it 'must have a projects method' do
      client.must_respond_to :topics
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

