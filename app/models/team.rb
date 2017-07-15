# == Schema Information
#
# Table name: teams
#
#  id           :integer          not null, primary key
#  name         :string
#  logo_url     :string
#  team_url     :string
#  fixtures_url :string
#  players_url  :string
#  shortname    :string
#  code         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Team < ApplicationRecord
  has_many :highlights
  has_many :players, through: :highlights

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.assignment_hash(data)
    #convert json data (from footballdata.org API) into a hash for mass assignment
    {
      name: data["name"],
      logo: data["crestUrl"],
      team_url: data["_links"]["self"]["href"],
      fixtures_url: data["_links"]["fixtures"]["href"],
      players_url: data["_links"]["players"]["href"],
      shortname: data["shortName"],
      code: data["code"],
    }
  end
end
