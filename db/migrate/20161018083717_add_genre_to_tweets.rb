class AddGenreToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :genre, :text
  end
end
