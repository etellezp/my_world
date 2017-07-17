class CreateTravelers < ActiveRecord::Migration
  def change
    create_table :travelers do |t|
      t.string :username
      t.string :email
      t.string :password_digest
    end
  end
end
