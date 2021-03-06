require 'capybara/poltergeist'

class Scraping
  def self.scraping_crowd(session, today, check_time)
    can_reserve_from_web = false   # web予約可能か
    crowd = 0                      # 混んでいるか

    # 店舗名・住所・ジャンル取得
    name = session.all(".rst-name")[0].all("p")[0].text
    address = session.find(".address").all("p")[0].text
    genre = session.all(".linktree__parent-target-text")[2].text
    check_time = 1800

    # webからの予約が可能か確認
    begin
      session.all(".js-show-yoyaku-modal-trigger")[0].trigger("click")
      can_reserve_from_web = true

      calender = session.find(".js-week-wrap")
      today_button_class = calender.all("p")[today-1][:class]
      if today_button_class.include?("is-selectable")
        crowd = 0
        puts "空いてる"
      else
        crowd = 1
        puts "混んでる"
      end

    # web予約不可（webから混雑状況確認できない）
    rescue
      puts "web予約不可"
    end

    puts name
    puts address
    puts genre
    print(can_reserve_from_web, crowd, "\n")
    return address, genre, can_reserve_from_web, crowd
  end


  # データをDBに格納
  def self.save_db(address, genre, crowd)
    tweet = Tweet.where(address: address).first_or_initialize
    tweet.user_id  = 0
    tweet.address  = address
    tweet.genre    = genre
    tweet.is_crowd = crowd
    tweet.save()
  end


  # 食べログから混雑状況をスクレイピング
  def self.scraping_from_tabelog
    # root_url = "https://tabelog.com/"
    # search_url = "https://tabelog.com/hyogo/A2801/A280108/"
    search_url = "https://tabelog.com/tokyo/A1302/A130201/R6586/rstLst/"

    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 1000})
    end
    session = Capybara::Session.new(:poltergeist)
    session.visit search_url
    # area_input = session.find("#js-header-area").find("input")
    # area_input.native.send_key('渋谷駅')
    # key_input  = session.find("#js-header-key").find("input")
    # key_input.native.send_key('居酒屋')
    # session.find("#js-global-search-btn").trigger("click")
    page_count = 1

    # 現在時刻取得
    today = Time.now.day
    now = Time.now
    if now.min >= 30
      check_time = (now.hour+1).to_s + "00"
    else
      check_time = now.hour.to_s + "30"
    end
    puts check_time

    while true
      session.visit search_url
      stores = session.all(".list-rst__rst-name-target")
      store_urls = []
      stores.each do |store|
        store_urls << store[:href]
      end

      # 各店舗の混雑状況を確認（ web予約可能か確認 -> 営業時間内か確認 -> 空室か確認 ）
      for i in 0..(store_urls.length-1) do
        puts "----------------------------------"
        puts store_urls[i]
        sleep(1)
        session.visit store_urls[i]
        address, genre, can_reserve_from_web, crowd = scraping_crowd(session, today, check_time)

        # web予約可能ならデータベースに格納
        if can_reserve_from_web
          save_db(address, genre, crowd)
        end
      end

      # 次ページへのリンクに移動
      is_last_page = true
      page_count += 1
      session.visit search_url
      pagenation = session.find(".page-move__num").all("a")
      pagenation.each do |page|
        if page.text.to_i == page_count
          search_url = page[:href]
          puts "---------------------"
          puts search_url
          puts "---------------------"
          session.visit search_url
          is_last_page = false
          break
        end
      end
      # 次のページがなければ終了
      if is_last_page == true
        puts "終了"
        break
      end
    end
  end

  # hotpepperグルメから混雑状況をスクレイピング
  def scraping_from_hotpepper
    url = "https://www.hotpepper.jp/CSP/psh010/doBasic?FWT=%E4%B8%89%E5%AE%AE%E3%80%80%E5%B1%85%E9%85%92%E5%B1%8B&SA=SA24"
    agent = Mechanize.new
    html = agent.get(url)
    elements = html.search('.shopDetailTop')
    elements.each do |element|
      puts element.search('.calendarContainer')
    end
  end
end
