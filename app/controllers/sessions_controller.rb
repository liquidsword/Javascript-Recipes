class SessionsController < ApplicationController

  def new
     @culinary_artist = CulinaryArtist.new
   end

  def create
    @culinary_artist = CulinaryArtist.find_by(culinary_artist_id: session_params[:culinary_artist_id])
    session[:culinary_artist_name] = @culinary_artist_name #this should be culinary_artist_name because I set a cookie on the user's browser by writing their username into the session hash
    if @culinary_artist && @culinary_artist.authenticate(params[:culinary_artist][:password])
      session[:culinary_artist_name] = @culinary_artist_name
      redirect_to @culinary_artist #after logging in successfully it is redirected to the culinary_artists#show
    else
      @culinary_artist = CulinaryArtist.new(email: session_params[:email])
      flash[:error] = "Something went wrong, please try again"
      #render :new
    end
  end

  def destroy
    session[:culinary_artist_id] = nil
    redirect_to root_path, :notice => "Goodbye :)"
  end

  def omnicreate
    if auth_hash = request.env["omniauth.auth"]
      @culinary_artist = CulinaryArtist.find_or_create_by_omniauth(auth_hash)
      session[:culinary_artist_id] = @culinary_artist.id
      redirect_to @culinary_artist
    else
      render 'sessions/new'
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end

  def session_params
    params.require(:culinary_artist).permit(:culinary_artist_id, :culinary_artist_name, :password)
  end
end
