class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :desc
      t.string :location
      t.text :url
      t.text :image_url
      t.date :start_time
      t.date :end_time

      t.timestamps
    end
  end
end
