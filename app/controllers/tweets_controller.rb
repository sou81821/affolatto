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
    Tweet.create(is_crowd: create_params[:is_crowd], latitude: create_params[:latitude], longitude: create_params[:longitude], user_id: current_user.id)
    redirect_to action: :index
  end

  def get_position
    position = qiita_markdown(params[:text])
    pp position
    render text: position
  end

  private
  def create_params
    params.require(:tweet).permit(:is_crowd, :latitude, :longitude)
  end

end
