class RssUpdater
  include Sidekiq::Worker

  def perform
    feeds = SearchTerm.all
    feeds.each do |feed|
      feed.update_attribute :rss_url, Feedjira::Feed.update(feed)

    end

  end
end