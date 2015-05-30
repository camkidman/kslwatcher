class SearchTerm < ActiveRecord::Base
  has_one :feed
  belongs_to :user

  after_create :assign_ksl_query_string
  after_create :create_feedjira_feed

  def parse_term_to_html_string(string)
    string.gsub(' ', '%20')
  end

  def ksl_query_string(query)
    "http://www.ksl.com/resources/classifieds/rss_.xml?nid=231&nocache=1&search=#{parse_term_to_html_string(query)}&zip=&distance=&min_price=&max_price=&type=&x=0&y=0&__ssid=89cfb83a-0463-46c4-9200-dc1fe2db08e7&__atuvc=3|6&recdA=b3b3bda81bf54b3d467789bebd20f016&optimizelyEndUserId=oeu1424916602065r0.1200678946916014&_parsely_visitor={\%22id\%22:\%220ba3deb0-e9b5-4736-ad36-e7e7879fe7fb\%22,\%22session_count\%22:1,\%22last_session_ts\%22:1424916604521}&_cb_ls=1&s_vmonthnum=1433138400038&vn=1&s_fid=334A4527F3A95446-28761FC6A962C290&s_nr=1430511483219-Repeat&optimizelySegments={\%22338861471\%22:\%22false\%22,\%22339714229\%22:\%22direct\%22,\%22339759493\%22:\%22gc\%22,\%22339916197\%22:\%22none\%22}&optimizelyBuckets={}&cX_S=ia61a3nna3c6qmjy&cX_P=i3noz622w81huram&sid=0&viewNumResults=50"
  end

  def due_to_expire?
    updated_at < 7.days.ago
  end

  def cancel_term
    update_attribute :expired, true
    update_attribute :expired_at, Time.now
  end

  private

  def assign_ksl_query_string
    self.update_attribute :rss_url, ksl_query_string(self.term)
  end

  def create_feedjira_feed
    self.create_feed(serialized_feedjira: YAML::dump(Feedjira::Feed.fetch_and_parse(self.rss_url)))
  end
end
