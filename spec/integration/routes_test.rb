class RoutesTest < ActionDispatch::IntegrationTest
  test 'routes version' do
    assert_generates '/v1/zombies', { controller: 'v1/zombies', action: 'index' }
    assert_generates '/v2/zombies', { controller: 'v2/zombies', action: 'index' }
  end
end

#TO USE ACCEPT HEADER METHOD
class RoutesTest < ActionDispatch::IntegrationTest
  test 'defaults to v2' do
    assert_generates '/zombies', { controller: 'v2/zombies', action: 'index' }
  end
end
