require "csv"

tweet_csv = CSV.readlines("db/tweets.csv")
tweet_csv.shift
tweet_csv.each do |row|
  Tweet.create(user_id: row[1], address: row[2], is_crowd: row[4], latitude: row[7], longitude: row[8], genre: row[9])
end
