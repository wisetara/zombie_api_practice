require 'spec_helper'

class ListingZombiesTest < ActionDispatch::IntegrationTest

  setup { host! 'api.example.com' }

  test 'returns list of all zombies' do
    john = Zombie.create!(name: 'John', weapon: 'axe')
    joanna = Zombie.create!(name: 'Joanna', weapon: 'shotgun')


    get '/zombies?weapon=axe'
    assert_equal 200, response.status
    refute_empty response.body

    zombies = JSON.parse(response.body, symbolize_names: true)
    #HELPER METHOD FOR THE ABOVE (requires addition to spec_helper):
    #json(response.body)
    names = zombies.collect { |z| z[:name] }
    assert_includes names, 'John' #the one who should show
    refute_includes names, 'Joanna' #the one who should not show
  end

  test 'returns one zombie' do
    zombie = Zombie.create!(name: 'Joanna', weapon: 'axe')
    get "/zombies/#{zombie.id}" #routes to Zombies#show
    assert_equal 200, response.status
    refute_empty response.body

    zombie_response = JSON.parse(response.body, symbolize_names: true)
    #HELPER METHOD FOR THE ABOVE (requires addition to spec_helper):
    #json(response.body)
    assert_equal zombie.name, zombie_response[:name]
  end

  test 'returns zombies in JSON' do
    get '/zombies', {}, { 'Accept' => Mime::JSON }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test 'returns zombies in XML' do
    get '/zombies', {}, { 'Accept' => Mime::XML }
    assert_equal 200, response.status
    assert_equal Mime::XML, response.content_type
  end

  setup { @user = User.create!(username: 'foo', password: 'secret') }

  test 'valid authentication lists zombies' do
    get '/zombies', {}, { 'Authorization' => encode_credentials(@user.username, @user.password) }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test 'invalid authentication responds with proper status code' do
    get '/zombies'
  end


end
