class AddUserIdToSearchTerm < ActiveRecord::Migration
  def change
    add_reference :search_terms, :user, index: true
  end
end
