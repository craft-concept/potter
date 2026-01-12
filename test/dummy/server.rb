require "sinatra/base"

module Dummy
  class Server < Sinatra::Base
    get "/posts" do
      "Hello world!"
    end
  end
end
