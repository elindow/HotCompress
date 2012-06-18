class AddHitCountToUrlPair < ActiveRecord::Migration
  def change
    add_column :url_pairs, :hit_count, :integer
  end
end
