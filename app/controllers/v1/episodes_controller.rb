#use module V# when you have more than one version
#I use this version to practice user authentication via API
module V1
  class EpisodesController < ApplicationController
    before_action :authenticate

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

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Basic realm="Episodes"'

      respond_to do |format|
        format.json { render json: 'Bad credentials', status: 401 }
        format.xml { render xml: 'Bad credentials', status: 401 }
      end
    end
    #ALTERNATIVE WITH TOKENS
    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Episodes"'

      respond_to do |format|
        format.json { render json: 'Bad credentials', status: 401 }
        format.xml { render xml: 'Bad credentials', status: 401 }
      end
    end


    protected
      def authenticate
        #authenticate_or_request_with_http_basic do |username, password|
          #User.authenticate(username, password)
          #THIS GIVES MORE CONTROL
          #authenticate_basic_auth || render_unauthorized
          #THIS USES A TOKEN:
          authenticate_token || render_unauthorized

          authenticate_or_request_with_http_token do |token, options|
            User.find_by(auth_token: token)
          end
      end

      def authenticate_with_http_basic do |username, password|
        #returns a boolean but doesn't halt
        User.authenticate(username, password)
        end
      end

      def authenticate_token
        authenticate_with_http_token do |token, options|
          User.find_by(auth_token: token)
        end
      end

    private
    def episode_params
      params.require(:episode).permit(:title, :description)
    end
  end
end
