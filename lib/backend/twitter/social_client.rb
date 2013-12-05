require 'twitter'
require 'yaml'

module Twitter
  class SocialClient
    def initialize
      config = load_config(SocialGedoens::CONFIG_PATH+"/twitter.yml")
      @client = create_client(config)
    end

    def message(text)
      @client.update text
    end

    private

    def load_config(path)
      YAML.load(File.read(path))
    end

    def create_client(config)
      Twitter::REST::Client.new do |configuration|
        configuration.consumer_key        = config["twitter"]["consumer_key"]
        configuration.consumer_secret     = config["twitter"]["consumer_secret"]
        configuration.access_token        = config["twitter"]["access_token"]
        configuration.access_token_secret = config["twitter"]["access_token_secret"]
      end
    end

  end
end
