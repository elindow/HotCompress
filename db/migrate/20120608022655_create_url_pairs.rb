class CreateUrlPairs < ActiveRecord::Migration
  def change
    create_table :url_pairs do |t|
      t.string :long_url
      t.string :short_url
      t.integer :user_id

      t.timestamps
    end
	
	add_index :url_pairs, :short_url, :unique => true
  end
end
