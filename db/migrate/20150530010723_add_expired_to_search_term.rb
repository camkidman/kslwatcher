class AddExpiredToSearchTerm < ActiveRecord::Migration
  def change
    add_column :search_terms, :expired, :boolean
  end
end
