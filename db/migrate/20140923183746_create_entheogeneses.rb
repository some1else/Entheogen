class CreateEntheogeneses < ActiveRecord::Migration
  def change
    create_table :entheogeneses do |t|
      t.text :body

      t.timestamps
    end
  end
end
