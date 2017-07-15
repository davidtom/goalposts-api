# == Schema Information
#
# Table name: highlights
#
#  id                 :integer          not null, primary key
#  title              :string
#  permalink          :string
#  url                :string
#  media              :text
#  media_embed        :text
#  secure_media       :text
#  secure_media_embed :text
#  created            :datetime
#  created_utc        :datetime
#  player_id          :integer
#  team_id            :integer
#  domain_id          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class HighlightTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
