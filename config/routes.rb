RestfulApiRails::Application.routes.draw do
  #Same thing: constraints subdomain: 'api' do
    #namespace :api, path: '/' do
namespace :api, path: '/', constraints: { subdomain: 'api' } do
  #resources :zombies
  #resources :humans
  end
end

#resources :pages
