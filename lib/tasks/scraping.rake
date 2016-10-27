task :scraping_task => :environment do
  Scraping.scraping_from_tabelog
end
