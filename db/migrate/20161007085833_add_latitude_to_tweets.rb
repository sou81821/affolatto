class AddLatitudeToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :latitude, :float
    add_column :tweets, :longitude, :float
  end
end
