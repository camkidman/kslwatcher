class AddExpiredAtToSearchTerm < ActiveRecord::Migration
  def change
    add_column :search_terms, :expired_at, :datetime
  end
end
