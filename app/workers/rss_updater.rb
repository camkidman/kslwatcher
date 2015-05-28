class RssUpdater
  include Sidekiq::Worker

  def perform
    all_terms = SearchTerm.all
    all_terms.each do |term|
      updated_feed = Feedjira::Feed.update(YAML::load(term.feed.serialized_feedjira))
      unless updated_feed.new_entries.blank?
        updated_feed.new_entries.each {|new_entry| NotificationMailer.new_post(term.user, term.term, new_entry.url).deliver_now }
        term.feed.update_attribute :serialized_feedjira, updated_feed
      end
    end
  end

end