class HomePageController < ApplicationController


  def home
    if session[:culinary_artist_id]
      @culinary_artist = CulinaryArtist.find_by(session[:email])
    end
  end
end
