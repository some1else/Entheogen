class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image
      t.integer :position
      t.belongs_to :gallery, index: true

      t.timestamps
    end
  end
end
