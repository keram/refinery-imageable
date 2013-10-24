Refinery::Core::Engine.routes.draw do
  namespace :admin, path: Refinery::Core.backend_route do
    resources :imagenization, except: :show
  end
end
