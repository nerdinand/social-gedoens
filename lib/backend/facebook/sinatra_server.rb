require 'sinatra/base'

class Facebook::SinatraServer < Sinatra::Base
  def self.client=(client)
    @@client = client
  end

  get '/callback' do
    @@client.oauth_token = params["code"]
  end

  after '/callback' do
    self.class.send(:quit!)
  end
end
