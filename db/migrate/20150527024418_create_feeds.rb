class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.text :serialized_feedjira
      t.integer :search_term_id

      t.timestamps
    end
  end
end
