require_relative 'spec_helper'
require 'ffaker'
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

  describe 'add texts' do
    let(:texts) {[{
                      'text' => "As in indoor volleyball, the object of the game is to send the ball over the net and to ground it on the opponent's court, and to prevent the same effort by the opponent. A team is allowed up to three touches to return the ball across the net",
                      'postId' => FFaker::Address.building_number,
                      'timestamp' => DateTime.now.iso8601,
                      'user' => FFaker::Address.building_number,
                      'thisiscustom1' => FFaker::Internet.safe_email,
                      '2ndcust' => FFaker::Product.product_name
                  }, {
                      'text' => "Volleyball Magazine staged the event the next year at the same location, this time sponsored by Schlitz Light Beer. In 1978 Wilk formed a sports promotion company named Event Concepts with Craig Masuoka and moved the World Championship of Beach Volleyball to Redondo Beach. Jose Cuervo tequila signed on as sponsor and the prize purse. The event was successful and Cuervo funded an expansion the next year to three events. The California Pro Beach Tour debuted with events in Laguna Beach, Santa Barbara and the World Championship in Redondo.",
                      'postId' => FFaker::Address.building_number,
                      'timestamp' => DateTime.now.iso8601,
                      'user' => FFaker::Address.building_number,
                      'thisiscustom1' => FFaker::Internet.safe_email,
                      '2ndcust' => FFaker::Product.product_name
                  }]}
    let(:textsadded) { client.addTexts '5565b2dbca61f25d0302d1d9', texts }

    before do
      VCR.insert_cassette 'addtexts', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it 'must have a addTexts method' do
      client.must_respond_to :addTexts
    end

    it 'must parse the addTexts api response from JSON to Hash' do
      textsadded.must_be_instance_of Hash
    end

    it 'must have properties imported and errors' do
      textsadded.must_include 'imported'
      textsadded.must_include 'errors'
    end

    describe 'errors' do
      let(:errors) { textsadded['errors'] }

      it 'must be an Array' do
        errors.must_be_instance_of Array
      end

      it 'must be empty' do
        errors.must_be_empty
      end
    end

    describe 'imported' do
      let(:taimported) { textsadded['imported'] }

      it 'must have at least one result' do
        taimported.wont_be_empty
      end
    end
  end

  # TODO: add test for text with textid
  # TODO: add test for text with source and postid
end

