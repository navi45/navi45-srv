class CreateApiV1Events < ActiveRecord::Migration
  def change
    create_table :api_v1_events do |t|
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
