class EpisodesController < ApplicationController

  def create
    episode = Episode.new(episode_params)
    if episode.save
      render json: episode, status: 201, location: episode
      #: Use this bad boy for successful responses with no response body. Like AJAX
      #render nothing: true, status: 204, location: episode
      #Another option is the head message:
      #head 204, location: episode; head :no_content also works
    else
      render json: episode.errors, status: 422
    end
  end

  def update
    episode = Episode.find(params[:id])
    if episode.update(episode_params)
      render json: episode, status: 200
    end
  end

  private
  def episode_params
    params.require(:episode).permit(:title, :description)
  end
end
