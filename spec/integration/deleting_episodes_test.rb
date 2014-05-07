class DeletingEpisodesTest < ActionDispatch::IntegrationTest
  setup { @episode = Episode.create(title: 'I am going to be deleted') }

  test 'deletes existing episode' do
    delete "/episodes/#{@episode.id}"
    assert_equal 204, response.status
  end
end
