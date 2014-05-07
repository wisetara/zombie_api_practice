class UpdatingEpisodesTest < ActionDispatch::IntegrationTest
  setup { @episode = Episode.create!(title: 'First Thing') }

  test 'successful update' do
    patch "/episodes/#{@episode.id}",
      { episode: { title: 'Ash' } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 200, response.status
    assert_equal 'Ash', @episode.reload.title
  end

  test 'unsuccessful update on short title' do
    patch "/episodes/#{@episode.id}",
      { episode: { title: 'short'} }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
  end
end
