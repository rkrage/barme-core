module Api
  class BeersController < BaseController
    def show
      render json: beer
    end

    private

    def beer_id
      params[:id]
    end

    def beer
      @beer ||= Beer.cached_json(beer_id) || Beer.find(beer_id)
    end
  end
end
