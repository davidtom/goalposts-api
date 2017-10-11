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
  scope :no_team, -> {where(team_id: nil)}

  @@conn = ActiveRecord::Base.connection

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

  def self.json_attributes(highlights)
    highlights.collect do |highlight|
      {
        id: highlight["id"],
        title: highlight["title"],
        url: highlight["url"],
        permalink: highlight["permalink"],
        media_embed: Highlight.get_clean_media_embed(highlight["media_embed"]),
        posted_utc_date: highlight["posted_utc"].to_datetime.to_date,
        posted_utc_time: highlight["posted_utc"].to_datetime.strftime("%H:%M:%S")
      }
    end
  end

  def self.all_reduced
    # Selects all highlights from database and returns them with a reduced number of attributes
    Highlight.json_attributes(Highlight.ordered_all)
  end

  def self.search_reduced(query, sort_options)
    # Selects all highlights from database that match the search query and returns them with a reduced number of attributes
    # Set up database connection and search terms/sort options
    query_anywhere = "%#{query}%"
    sort_params = self.get_sort_params(sort_options, query)
    # Execute PG search query
    result = @@conn.execute(%Q{SELECT * FROM highlights WHERE title ILIKE #{@@conn.quote(query_anywhere)} ORDER BY #{sort_params}})
    # Iterate over results and reduce/transform attributes of each highlight
    Highlight.json_attributes(result)
  end

  def self.get_sort_params(options, query)
    query_at_start = "#{query}%"
    if options
      col = options.split("=")[0]
      order = options.split("=")[1].upcase
      return @@conn.quote_string("#{col} #{order}")
    else
      "(title ILIKE #{@@conn.quote(query_at_start)}) DESC, title"
    end
  end

  def self.get_clean_media_embed(media_embed_string)
    # Class method to be used on any string
    #Slice out text between <iframe> tags and remove backlashes
    #If there is no iframe tags found, will return a string to be displayed instead
    iframe_string = media_embed_string.scan(/<iframe.+<\/iframe>/)[0]
    if !iframe_string.nil?
      iframe_string.gsub("\\","")
    else
      nil
    end
  end

  def self.get_utc_date(posted_utc)
    #returns only the date from a UTC datetime
    posted_utc.to_datetime.to_date
  end

  def self.get_utc_time(posted_utc)
    #returns only the time (HH:MM:SS) from a UTC datetime
    posted_utc.to_datetime.strftime("%H:%M:%S")
  end

  def clean_media_embed
    # Method for an instance of Model class
    #Slice out text between <iframe> tags and remove backlashes
    #If there is no iframe tags found, will return a string to be displayed instead
    Highlight.get_clean_media_embed(self.media_embed)
  end

  def posted_utc_date
    #returns only the date when the highlight was posted to reddit
    Highlight.get_utc_date(posted_utc)
  end

  def posted_utc_time
    #returns only the time (HH:MM:SS) when the highlight was posted to reddit
    Highlight.get_utc_time(posted_utc)
  end

  def reddit_link
    "http://www.reddit.com#{permalink}"
  end

end
