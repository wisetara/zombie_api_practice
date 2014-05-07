class ListingEpisodesTest < ActionDispatch::IntegrationTest
  setup { @user = User.create!(username: 'foo', password: 'secret') }

  test 'valid username and password' do
    get '/episodes', {}, { 'Authorization' => encode(@user.username, @user.password) }
    assert_equal 200, response.status
  end

  test 'missing credentials' do
    get '/episodes', {}, {}
    assert_equal 401, response.status
  end

  test 'valid authentication with token' do
    get '/episodes', {}, { 'Authorization' => "Token token=#{@user.auth_token}"}
    #With helper method in utilities:
    get '/episodes', {}, { 'Authorization' => token_header(@user.auth_token) }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response,content_type
  end

  test 'invalid authentication' do
    get '/episodes' {}, { 'Authorization' => @user.auth_token + 'fake' }
    assert_equal 401, response.status
  end
end
