class MapsController < ApplicationController

  def index
    @tweets = Tweet.all
    @hash = Gmaps4rails.build_markers(@tweets) do |tweet, marker|
      marker.lat tweet.latitude
      marker.lng tweet.longitude
      marker.infowindow tweet.address
      marker.json({ title: tweet.id })
    end
  end

  def new
  end

end
