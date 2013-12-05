require 'yaml'
require 'fb_graph'
require 'sinatra'

module Facebook
  class SocialClient
    attr_accessor :oauth_token

    def initialize
      config = load_config(SocialGedoens::CONFIG_PATH+"/facebook.yml")
      @user = create_client(config)
      @oauth_token = nil
    end

    def message(text)
      @user.feed!(
        :message => text,
        # :picture => 'https://graph.facebook.com/matake/picture',
        # :link => 'https://github.com/nov/fb_graph',
        # :name => 'FbGraph',
        # :description => 'A Ruby wrapper for Facebook Graph API'
      )
    end

    private

    def load_config(path)
      YAML.load(File.read(path))
    end

    def create_client(config)
      fb_auth = FbGraph::Auth.new(config["facebook"]["api_key"], config["facebook"]["app_secret"])
      client = fb_auth.client

      client.redirect_uri = "http://localhost:4567/callback"

      Facebook::SinatraServer.client = self
      Thread.new { Facebook::SinatraServer.run! }

      `open "#{client.authorization_uri}"`

      while oauth_token.nil?
        sleep 1
      end

      client.authorization_code = oauth_token
      access_token = client.access_token! :client_auth_body

      FbGraph::User.me(access_token)
    end

  end
end
