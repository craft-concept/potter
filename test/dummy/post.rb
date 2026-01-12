module Dummy
  class Post
    include Potter::Model

    string :title
    text   :body
    json   :metadata
  end
end
