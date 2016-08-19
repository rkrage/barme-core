module Api
  class BeersController < BaseController
    def show
      render json: beer
    end

    private

    def beer
      @beer ||= Beer.find(params[:id])
    end
  end
end
