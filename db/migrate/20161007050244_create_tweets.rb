class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.text :address
      t.integer :is_business_hour
      t.integer :is_crowd
      t.timestamps
    end
  end
end
