Refinery::Core::Engine.routes.draw do
  namespace :admin, path: Refinery::Core.backend_route do
    resources :imagenization, only: :destroy
  end
end
