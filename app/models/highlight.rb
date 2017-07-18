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
#  posted             :datetime
#  posted_utc         :datetime
#  player_id          :integer
#  team_id            :integer
#  domain_id          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Highlight < ApplicationRecord
  belongs_to :domain, optional: true
  belongs_to :player, optional: true
  belongs_to :team, optional: true

  validates :title, uniqueness: true

  scope :ordered_all, -> {order("cast(posted_utc as date) DESC, cast(posted_utc as time) ASC")}

  def self.assignment_hash(post)
    #convert data from a redd post object into a hash for mass assignment
  {
    title: post.title,
    permalink: post.permalink,
    url: post.url,
    media: post.media,
    media_embed: post.media_embed,
    secure_media: post.secure_media,
    secure_media_embed: post.secure_media_embed,
    posted: Time.at(post.created), #full datetime when posted, local time of poster
    posted_utc: Time.at(post.created_utc), #full datetime when posted, utc time
  }
  end

  def posted_utc_date
    #returns only the date when the highlight was posted to reddit
    posted_utc.to_datetime.to_date
  end

  def posted_utc_time
    #returns only the time (HH:MM:SS) when the highlight was posted to reddit
    posted_utc.to_datetime.strftime("%H:%M:%S")
  end

  def reddit_link
    "http://www.reddit.com#{permalink}"
  end

  def clean_media_embed
    #Slice out text between <iframe> tags and remove backlashes
    #If there is no iframe tags found, will return a string to be displayed instead
    iframe_string = self.media_embed.scan(/<iframe.+<\/iframe>/)[0]
    if !iframe_string.nil?
      iframe_string.gsub("\\","")
    else
      "Media embed not found - view highlight from source (link below)"
    end
  end

end
