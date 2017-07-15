class RedditAPIRunner

  def self.session
    Redd.it(
      user_agent: "Goal_Highlights",
      client_id: "_6Ql0Wm5PO_ABA",
      secret: "asRLazsZt8mK1Q4tjqUevZxGSkU",
      username: "Shabla_goo32",
      password: "jsoccer4"
    )
  end

  def self.socket
    session.subreddit("soccer")
  end

  def self.valid_flair?(flair)
    #Check if post flair indicates it is media (array in case it expands)
    ["Media"].include?(flair) ? true : false
  end

  def self.remove_spaces(string)
    #remove all spaces from a string, to eliminate issues with regex parsing below
    string.gsub(/\s+/, '')
  end

  def self.has_minute?(post_title)
    # Search for and return a ###' pattern in the title; forces 3 digits to
    #  avoid matching years (e.g. 1999's Copa America)
    remove_spaces(post_title).scan(/\s[0-9]{1,3}'/).any? ? true : false
  end

  def self.has_score?(post_title)
    # Search for and return everything matching this pattern: (#-#)
    remove_spaces(post_title).scan(/\(\d+-\d+\)/).any? ? true : false
  end

  def self.has_penalty?(post_title)
    # Search for and return any instance of penalty in down-cased post title
    remove_spaces(post_title).downcase.scan(/penalty/).any? ? true : false
  end

  def self.meets_goal_criteria(flair, post_title)
    #combines methods above to check all criteria that indicate a post is a goal highlight
    t = post_title
    valid_flair?(flair) && (has_minute?(t) || has_score?(t) || has_penalty?(t))
  end

  def self.test_scan
    #View post stream and verify that #meets_goal_criteria is working correctly
    socket.post_stream do |post|
      puts post.title
      puts post.link_flair_text
      puts meets_goal_criteria(post.link_flair_text, post.title)
      puts "----------"
    end
  end

  def self.create_highlight_if_valid(post)
    # Creates a highlight, with domain, from a post if it is a valid goal highlight
    # Also check to make sure that the highlight is valid inside the database
    if meets_goal_criteria(post.link_flair_text, post.title)
      Highlight.new(Highlight.assignment_hash(post)).tap do |h|
        if h.save
          h.domain = Domain.find_or_create_by(name: post.domain)
          h.save
        end
      end
    end
  end

  def self.scan_new
    # Go through 50 newest posts on /r/soccer and add goal highlights to db
    socket.new.each do |post|
      create_highlight_if_valid(post)
    end
  end

  def self.scan_stream
    # Go through 100 newest posts on /r/soccer AND continuously watch for new
    #  posts, adding any goal highlights to db
    socket.post_stream do |post|
      create_highlight_if_valid(post)
    end
  end

end
