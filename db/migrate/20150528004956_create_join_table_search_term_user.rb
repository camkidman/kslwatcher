class CreateJoinTableSearchTermUser < ActiveRecord::Migration
  def change
    create_join_table :search_terms, :users do |t|
      # t.index [:search_term_id, :user_id]
      # t.index [:user_id, :search_term_id]
    end
  end
end
