RestfulApiRails::Application.routes.draw do
  #Same thing: constraints subdomain: 'api' do
    #namespace :api, path: '/' do
#@namespace :api, path: '/', constraints: { subdomain: 'api' } do
  #resources :zombies
  #resources :humans

#resources :pages

#this is for API-only, so it doesn't need the api indicator:

  namespace :v1 do
    resources :zombies
  end

  namespace :v2 do
    resources :zombies
  end
end

#This is for the ACCEPT HEADER method:

require 'api_version'
CodeSchoolZombies::Application.routes.draw do

  scope defaults: { format: 'json' } do
    scope module: :v1, constraints: ApiVersion.new('v1') do
      resources :zombies
    end

#default version MUST go last
    scope module: :v2, constraints: ApiVersion.new('v2', true) do
      resources :zombies
    end
  end
end
