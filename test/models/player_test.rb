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

require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
