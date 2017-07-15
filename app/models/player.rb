# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string
#  dob        :date
#  country_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Player < ApplicationRecord
  belongs_to :country, optional: true
  has_many :highlights
  has_many :teams, through: :highlights

  validates :name, presence: true

end
