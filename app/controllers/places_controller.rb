class PlacesController < ApplicationController

  def index
  end

  def show
  end

  def search
    if params[:city].length == 0
      redirect_to places_path, notice: "City field cannot be empty."
    else
      @places = BeermappingApi.places_in(params[:city])
      if @places.empty?
        redirect_to places_path, notice: "No locations in #{params[:city]}."
      else
        render :index
      end
    end
  end
end
