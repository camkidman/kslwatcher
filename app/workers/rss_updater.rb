class RssUpdater
  include Sidekiq::Worker

  def perform
    all_terms = SearchTerm.all
    all_terms.each do |term|
      updated_feed = Feedjira::Feed.update(YAML::load(term.feed))
      unless updated_feed.new_entries.blank?
        updated_feed.new_entries.each {|new_entry| EmailQueue.new(term.user, new_entry.url) } #TODO: I just made this up, need to implement an actual email queue system.
      end
    end
  end

end