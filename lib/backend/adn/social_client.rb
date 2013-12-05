require 'adn'
require 'yaml'

module Adn
  class SocialClient
    def initialize
      config = load_config(SocialGedoens::CONFIG_PATH+"/adn.yml")
      create_client(config)
    end

    def message(text)
      ADN::Post.send_post({text: text})
    end

    private

    def load_config(path)
      YAML.load(File.read(path))
    end

    def create_client(config)
      ADN.token = config["adn"]["oauth_token"]
    end

  end
end
