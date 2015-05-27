json.array!(@search_terms) do |search_term|
  json.extract! search_term, :id, :term, :rss_url
  json.url search_term_url(search_term, format: :json)
end
