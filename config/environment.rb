# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env != 'development'
  Rails.logger = Le.new('e676514c-1882-48c9-ac30-e5bb518d3bfe')
else
  Rails.logger = Le.new('e676514c-1882-48c9-ac30-e5bb518d3bfe', local: true)
end