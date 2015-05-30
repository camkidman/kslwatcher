class TermExpiration
  include Sidekiq::Worker

  def perform
    s = SearchTerm.all
    s.each do |search_term|
      if search_term.due_to_expire?
        search_term.update_attribute :expired, true
        search_term.update_attribute :expired_at, Time.now
      end
    end
  end

end