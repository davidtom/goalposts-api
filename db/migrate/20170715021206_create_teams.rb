class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :logo_url
      t.string :team_url
      t.string :fixtures_url
      t.string :players_url
      t.string :shortname
      t.string :code

      t.timestamps
    end
  end
end
