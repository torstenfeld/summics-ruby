require 'logger'
require 'faraday'
require 'json'
require_relative 'summics/version'


module Summics
  class Client
    # include HTTParty
    # attr_reader :endpoints

    HOST = 'https://api.summics.com'

    ENDPOINTS = {
        :authenticate => {
            :url => '/auth',
            :method => 'post'
        },
        :projects => {
            :url => '/projects'
        },
        :topics => {
            :url => '/topics'
        },
        :topicsOverview => {
            :url => '/topics/overview'
        },
        :texts => {
            :url => '/texts'
        },
        :textByTextId => {
            :url => '/text/textId'
        },
        :textByPostId => {
            :url => '/text/{source_id}/{post_id}'
        },
        :dashboard => {
            :url => '/dashboard'
        },
        :addTexts => {
            :url => '/texts',
            :method => 'put',
            :ContentType => 'application/json'
        }
    }

    def initialize(client_id, client_secret, host=nil)
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG

      @logger.debug('initialize start')
      @client_id = client_id
      @client_secret = client_secret
      @token = nil
      @host = host || HOST
      # @logger.info("clientid: #{@client_id.to_s}")
      @logger.info("using host: #{@host.to_s}")
      @conn = Faraday.new :url => @host, :ssl => {:verify => false}
      @logger.debug('initialize end')
    end

    public
    def test
      # res = @conn.get('http://www.test.com')
      # puts res.status
      # puts res.body
      # request :authenticate
      # projects
      topics '546244ae8db3f581419f1a42'
    end

    public
    def projects
      authenticate
      request :projects
    end

    public
    def topics(projectid)
      authenticate
      request :topics, {'projectId' => projectid}
    end

    public
    def topicsOverview(sources, date_from, date_to)
      # TODO: create topicsOverview
    end

    public
    def texts(sources, date_from, date_to, topics=nil)
      # TODO: create texts
    end

    public
    def dashboard(sources, date_from, date_to)
      # TODO: dashboard
    end

    public
    def addTexts(sourceid, texts)
      authenticate
      request :addTexts, {'sourceId' => sourceid, 'texts' => texts}

      # expected result
      # {"imported"=>["5582caa50c4d76c4f65642a3", "5582caa50c4d76c4f65642a4"], "errors"=>[]}
    end

    public
    def text(textid=nil, source=nil, postid=nil)
      # TODO: text
    end

    private
    def request(endpoint, param_dict={}, url_param_dict={})
      headers = {}
      endpoint = ENDPOINTS[endpoint]
      @logger.debug("endpoint_url: #{endpoint[:url]}")

      headers['Authorization'] = @token unless @token.nil?
      headers['Content-Type'] = endpoint[:ContentType] || 'application/x-www-form-urlencoded'

      @logger.debug("headers: #{headers.to_s}")
      @logger.debug("params: #{param_dict.to_s}")
      @logger.debug("using method: #{endpoint[:method] || 'get'}")

      case endpoint[:method]
        when 'put' then response_json = @conn.put(endpoint[:url], JSON.dump(param_dict), headers)
        when 'post' then response_json = @conn.post(endpoint[:url], param_dict, headers)
        else response_json = @conn.get(endpoint[:url], param_dict, headers)
      end

      @logger.debug("response status: #{response_json.status}")
      response = JSON.parse(response_json.body)
      @logger.debug(response.to_s)
      response
    end

    private
    def authenticate
      if @token.nil?
        res = request(:authenticate, {'clientId' => @client_id, 'secret' => @client_secret})
        @token = res['token']
        @logger.debug("token set: #{@token}")
      end
    end

  end
end
