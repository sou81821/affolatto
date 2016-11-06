class TweetsController < ApplicationController

  def index
    @tweet = Tweet.new
    @genres = Tweet.uniq.pluck(:genre)
    @genres.unshift("ジャンル選択（全て）")

    @tweets = Tweet.all  # 全ツイート
    # @tweets = Tweet.where(updated_at: Time.zone.now-12*60*60..Time.zone.now)  # 直近半日のツイート（デモ用）
    # @tweets = Tweet.where(updated_at: Time.zone.now-30*60..Time.zone.now)   # 直近30分のツイート（本番用）

    @hash = Gmaps4rails.build_markers(@tweets) do |tweet, marker|
      marker.lat tweet.latitude
      marker.lng tweet.longitude
      marker.infowindow render_to_string(:partial => "tweet", :locals => { :@tweet => tweet, :is_top => true, :top_tweeted => true })
      marker.json({ title: tweet.id })
      if tweet.is_crowd == 1
        marker.picture({
          "url": "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|FFA500|000000",
          "width": 30,
          "height": 30
        })
      else
        marker.picture({
          "url": "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|FFFACD|000000",
          "width": 30,
          "height": 30
        })
      end
    end
  end

  def create
    Tweet.create(is_crowd: create_params[:is_crowd], latitude: create_params[:latitude], longitude: create_params[:longitude], user_id: current_user.id, genre: create_params[:genre])
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

  def search
    genre = params[:genre]
    @tweet = Tweet.new
    @genres = Tweet.uniq.pluck(:genre)
    @genres.unshift("ジャンル選択（全て）")

    if genre == "ジャンル選択（全て）"
      @tweets = Tweet.all
    else
      @tweets = Tweet.where(genre: genre)
    end

    @hash = Gmaps4rails.build_markers(@tweets) do |tweet, marker|
      marker.lat tweet.latitude
      marker.lng tweet.longitude
      marker.infowindow render_to_string(:partial => "tweet", :locals => { :@tweet => tweet, :is_top => true, :top_tweeted => true })
      marker.json({ title: tweet.id })
      if tweet.is_crowd == 1
        marker.picture({
          "url": "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|FFA500|000000",
          "width": 30,
          "height": 30
        })
      else
        marker.picture({
          "url": "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|FFFACD|000000",
          "width": 30,
          "height": 30
        })
      end
    end
    render 'index'
  end

  private
  def create_params
    params.require(:tweet).permit(:is_crowd, :latitude, :longitude, :genre)
  end

  def update_params
    params.require(:tweet).permit(:id, :is_crowd)
  end

end
