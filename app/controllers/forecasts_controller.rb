class ForecastsController < ApplicationController
  def index
  end

  def search
    @loc = Location.get_forecast_dtls(params[:location])
  end
end
