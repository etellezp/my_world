class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.string :location
      t.string :content
      t.integer :rating
      t.integer :traveler_id
    end
  end
end
