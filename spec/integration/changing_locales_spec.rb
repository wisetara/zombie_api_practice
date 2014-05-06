class ChangingLocalesTest < ActionDispatch::IntegrationTest

  test 'returns list of zombies in English' do
    get '/zombies', {}, {'Accept-Language' => 'en', 'Accept' => Mime::JSON }
    assert_equal 200, response.status
    zombies = json(response.body)
    assert_equal "Watch out for #{zombies[0][:name]}!", zombies[0][:message]
  end

test 'returns list of zombies in Portuguese' do
    get '/zombies', {}, {'Accept-Language' => 'pt-BR', 'Accept' => Mime::JSON }
    assert_equal 200, response.status
    zombies = json(response.body)
    assert_equal "Cuidado com #{zombies[0][:name]}!", zombies[0][:message]
  end
