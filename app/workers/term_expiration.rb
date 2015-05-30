class TermExpiration
  include Sidekiq::Worker

  def perform
    s = SearchTerm.all
    s.each do |search_term|
      if search_term.due_to_expire?
        search_term.update_attribute :expired, true
      end
    end
  end

end