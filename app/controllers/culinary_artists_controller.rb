class CulinaryArtistsController < ApplicationController

  def new
    @culinary_artist = CulinaryArtist.new
  end

  def index
    @culinary_artists = CulinaryArtist.all
  end

  def create
    @culinary_artist = CulinaryArtist.create(culinary_artist_params)
      if @culinary_artist.save
        session[:culinary_artist_name] = @culinary_artist_name
        redirect_to @culinary_artist, notice: "Welcome to your recipes!"
      else
        render :new
      end
    end

  def show
    @culinary_artist = CulinaryArtist.find(params[:id]) #added show method because of login from sessions controller
  end

private

  def require_login
    return head(:forbidden) unless session.include? :culinary_artist_id
  end

  def culinary_artist_params
    params.require(:culinary_artist).permit(:culinary_artist_name, :password, :password_confirmation)
  end
end
