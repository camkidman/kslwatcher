class AddStripeReferenceIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :stripe_reference_id, :string
  end
end
