module Dummy
  class Endpoints < Potter::Endpoints
    resources :posts, only: [:index]
  end
end
