class CreateHighlights < ActiveRecord::Migration[5.1]
  def change
    create_table :highlights do |t|
      t.string :title
      t.string :permalink
      t.string :url
      t.text :media
      t.text :media_embed
      t.text :secure_media
      t.text :secure_media_embed
      t.datetime :created
      t.datetime :created_utc
      t.integer :player_id
      t.integer :team_id
      t.integer :domain_id

      t.timestamps
    end
  end
end
