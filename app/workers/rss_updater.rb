class RssUpdater
  include Sidekiq::Worker

  def perform
    all_terms = SearchTerm.all
    all_terms.each do |term|
      updated_feed = Feedjira::Feed.update(YAML::load(term.feed.serialized_feedjira))
      unless updated_feed.new_entries.blank? && !term.expired
        updated_feed.new_entries.each {|new_entry| NotificationMailer.new_post(term.user, term.term, new_entry.url).deliver }
        term.feed.update_attribute :serialized_feedjira, YAML::dump(updated_feed)
      end
    end
  end

end