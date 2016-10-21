class UsersController < ApplicationController
  layout 'mypage'
  before_action :authenticate_user!

  def show
    if current_user.id != params[:id].to_i
      redirect_to action: 'show', id: current_user.id
    end

    @tweets = Tweet.where(user_id: current_user.id)
    @hash = Gmaps4rails.build_markers(@tweets) do |tweet, marker|
      marker.lat tweet.latitude
      marker.lng tweet.longitude
      marker.infowindow render_to_string(:partial => "tweets/tweet", :locals => { :@tweet => tweet, :is_top => false, :top_tweeted => false } )
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

end
