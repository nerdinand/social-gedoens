require_relative "backend/twitter"
require_relative "backend/facebook"
require_relative "backend/adn"

class SocialGedoens
  CONFIG_PATH = File.expand_path "~/.social-gedoens"

  def initialize

  end

  def go
    [
      Twitter::SocialClient.new,
      Facebook::SocialClient.new,
      Adn::SocialClient.new
    ].each do |client|
      client.message("Test with link: http://www.google.com")
    end
  end
end