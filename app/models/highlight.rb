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

 # player_id          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Highlight < ApplicationRecord
  belongs_to :domain, optional: true
  belongs_to :player, optional: true
  belongs_to :team, optional: true

  validates :title, uniqueness: true

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
    created: Time.at(post.created),
    created_utc: Time.at(post.created_utc)
  }
  end

  def self.extract_time(datetime_object)
    # Extract only the time (HH:MM:SS) from a DateTime object
    datetime_object.strftime("%H:%M:%S")
  end

  def self.all_group_and_order_by_date
    #TODO REFACTOR THIS TO USE SQL!!
    #Sort goals in ascending order by 'created_utc'; group by created_at.to_date
    #Returns a hash: {created_at.to_date: [highlights]} -sorted asc
    sorted_hash = {}
    self.order("created_utc ASC").each do |highlight|
      date = highlight.created_utc
      sorted_hash[date] = [] if sorted_hash[date].nil?
      sorted_hash[date] << highlight
    end
    #sort hash by keys; descending order by date
    Hash[sorted_hash.sort_by{|date, highlights| date}.reverse]
  end

  def created_utc_date
    #returns only the date when the highlight was posted to reddit
    created_utc.to_datetime.to_date
  end

  def created_utc_time
    #returns only the time when the highlight was posted to reddit
    Highlight.extract_time(created_utc.to_datetime)
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
