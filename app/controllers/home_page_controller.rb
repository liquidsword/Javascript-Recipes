class HomePageController < ApplicationController

  def show

  end

  def home
    if session[:culinary_artist_id]
      @culinary_artist = CulinaryArtist.find_by(session[:culinary_artist_id])
    end
  end
end
