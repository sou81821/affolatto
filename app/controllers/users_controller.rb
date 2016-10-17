class UsersController < ApplicationController

  def show
    @email = current_user.email
    @tweets = Tweet.where(user_id: current_user.id)
    @hash = Gmaps4rails.build_markers(@tweets) do |tweet, marker|
      marker.lat tweet.latitude
      marker.lng tweet.longitude
      marker.infowindow render_to_string(:partial => "tweet", :locals => {:tweet => tweet} )
      marker.json({ title: tweet.id })
    end
  end

end
