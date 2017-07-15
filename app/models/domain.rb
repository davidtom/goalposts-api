# == Schema Information
#
# Table name: domains
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Domain < ApplicationRecord
  has_many :highlights

  validates :name, presence: true
  validates :name, uniqueness: true

end
