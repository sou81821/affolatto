class TweetsController < ApplicationController

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all
    @hash = Gmaps4rails.build_markers(@tweets) do |tweet, marker|
      marker.lat tweet.latitude
      marker.lng tweet.longitude
      # marker.infowindow render_to_string(:partial => "tweet", :locals => { :@is_top => true })
      marker.json({ title: tweet.id })
      if tweet.is_crowd == 1
        marker.picture({
          # "picture" => path_to_image('/images/logo_avatar.png'),
          "url": "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|FF0000|000000",
          "width": 30,
          "height": 30
        })
      else
        marker.picture({
          "url": "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|90ee90|000000",
          "width": 30,
          "height": 30
        })
      end
    end
  end

  def create
    Tweet.create(is_crowd: create_params[:is_crowd], latitude: create_params[:latitude], longitude: create_params[:longitude], user_id: current_user.id)
    redirect_to action: :index
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to controller: 'users', action: 'show', id: current_user.id
  end

  def update
    tweet = Tweet.find(params[:tweet][:id])
    tweet.update(update_params)
    redirect_to controller: 'users', action: 'show', id: current_user.id
  end

  private
  def create_params
    params.require(:tweet).permit(:is_crowd, :latitude, :longitude)
  end

  def update_params
    params.require(:tweet).permit(:id, :is_crowd)
  end

end
