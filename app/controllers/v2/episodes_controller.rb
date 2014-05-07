#Use module V# when you have more than one version
module V2
  class EpisodesController < VersionController #Note that they now inherit from a new version controller we made!
    before_action :audit_logging_for_v2

    def index
      episodes = Episode.where(archived: false)
      render json: episodes, status: 200
    end

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
      else
        render json: episode.errors, status: 422
      end
    end

    def show
      episode = Episode.find_unarchived(params[:id])
      render json: episode, status: 200
    end

    def destroy
      episode = Episode.find_unarchived(params[:id])
      episode.archive
      head 204
    end

    def self.find_unarchived(id)
      find_by!(id: id, archived: false)
    end

    def archive
      self.archived = true
      self.save
    end

    private
    def episode_params
      params.require(:episode).permit(:title, :description)
    end
  end
