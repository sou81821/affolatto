# 出力先の指定
set :output, 'log/crontab.log'

# 実行環境の指定
set :environment, :development

# 毎日30分ごとに実行
every 30.minutes do
  runner "Scraping.scraping_from_tabelog"
end

# 設定追加・確認
# bundle exec whenever --update-crontab
# crontab -e(-l)

# 設定削除
# bundle exec whenever --clear-crontab
