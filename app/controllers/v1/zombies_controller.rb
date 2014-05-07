module API #only use for API portions of the web app
  class ZombiesController < ApplicationController
    def index
      zombies = Zombie.all
      if weapon = params[:weapon]
        zombies = zombies.where(weapon: weapon)
      end
      render json: zombies, status: 200
    end

    def show
      zombie = Zombie.find(params[:id])
      render json: zombie, status: 200 #'ok' is the same as '200'
    end
  end
end

#FOR NON-API
class ZombiesController < ApplicationController
  def index
    zombies = Zombie.all

    respond_to do |format|
      format.json { render json: zombies, status: 200 }
      format.xml {render xml: zombies, status: 200 }
      #If no block is used, then a template is required (no { render} )
    end
  end
end

#ONCE YOU NEED MORE THAN ONE VERSION
module V1
  class ZombiesController < ApplicationController
    #RELOCATED TO APPLICATION CONTROLLER: before_action ->{ @remote_ip = request.headers['REMOTE_ADDR'] }
    def index
      render json: "#{@remote_ip} Version One!", status: 200
    end
  end
end
