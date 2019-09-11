class CulinaryArtistsController < ApplicationController

  def new
    @culinary_artist = CulinaryArtist.new
  end

  def index
    @culinary_artists = CulinaryArtist.all
  end

  # def create
  #   #binding.pry
  #   @culinary_artist = CulinaryArtist.new(culinary_artist_params)
  #     if @culinary_artist.save
  #       session[:culinary_artist_id] = @culinary_artist_id
  #       redirect_to culinary_artist_recipes_path(@culinary_artist), notice: "Welcome to your recipes!"
  #     else
  #       binding.pry
  #       render :new
  #     end
  #   end

  def show
    @culinary_artist = CulinaryArtist.find(params[:id]) #added show method because of login from sessions controller
  end

private

  def require_login
    return head(:forbidden) unless session.include? :culinary_artist_id
  end

  def culinary_artist_params
    params.require(:culinary_artist).permit(:email, :password, :password_confirmation)
  end
end
