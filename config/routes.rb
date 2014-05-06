RestfulApiRails::Application.routes.draw do
  constraints subdomain: 'api' do
    namespace :api, path: '/' do
#Same thing: namespace :api, path: '/', constraints: { subdomain: 'api' } do
      resources :zombies
      resources :humans
  end
end

resources :pages
