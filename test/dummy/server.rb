require "sinatra/base"

class DummyServer < Sinatra::Base
  get "/posts" do
    "Hello world!"
  end
end
