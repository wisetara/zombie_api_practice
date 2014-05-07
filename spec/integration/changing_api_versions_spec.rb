class ChangingApiVersionsTest < ActionDispatch::IntegrationTest

  setup { @ip = '123.123.12.12' }

  test '/v1 returns version 1' do
    get '/v1/zombies', {}, { 'REMOTE_ADDR' => @ip }
    assert_equal "#{@ip} Version One!", response.body
  end

  test '/v2 returns version 2' do
    get '/v2/zombies', {}, { 'REMOTE_ADDR' => @ip }
    assert_equal 200, response.status
    assert_equal "#{@ip} Version Two!", response.body
  end
end


#integration testing api versions using the accept header

class ChangingApiVersionsTest < ActionDispatch::IntegrationTest
  setup { @ip = '123.123.12.12' }

  test 'returns version one via Accept header' do
    get '/zombies', {},
      { 'REMOTE_ADDR' => @ip, 'Accept' => 'application/vnd.apocalypse.v1+json' }

    assert_equal 200, response.status
    assert_equal "#{@ip} Version One!", response.body
    assert_equal Mime::JSON, response.content_type
  end
end

class ChangingApiVersionsTest < ActionDispatch::IntegrationTest
  setup { @ip = '123.123.12.12' }

  test 'returns version one via Accept header' do
    get '/zombies', {},
      { 'REMOTE_ADDR' => @ip, 'Accept' => 'application/vnd.apocalypse.v2+json' }

    assert_equal 200, response.status
    assert_equal "#{@ip} Version Two!", response.body
    assert_equal Mime::JSON, response.content_type
  end
end
