class TweetsController < ApplicationController

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all
    @hash = Gmaps4rails.build_markers(@tweets) do |tweet, marker|
      marker.lat tweet.latitude
      marker.lng tweet.longitude
      marker.infowindow "here"
      #marker.infowindow "<%= form_for @tweet do |f| %><%= f.text_area :introduction %><% end %>"
      marker.infowindow render_to_string(:partial => "tweet")
      marker.json({ title: tweet.id })
    end
  end

  def create
    Tweet.create(create_params)
    redirect_to action: :index
  end

  private
  def create_params
    params.require(:tweet).permit(:is_crowd)
  end

end
