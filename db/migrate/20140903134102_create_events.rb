class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :begins_at
      t.string :venue
      t.string :lineup
      t.string :fb_link

      t.timestamps
    end
  end
end
