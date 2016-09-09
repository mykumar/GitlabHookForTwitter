module GitLabTwitterHook
  class ClientBitly

    attr_reader :client

    def self.load
      client = new.client
    end

    def initialize
      config = GitLabTwitterHook::Config.config
      Bitly.use_api_version_3
      @client = Bitly.new(config[:bitly][:username], config[:bitly][:api_key])
    end

  end
end
