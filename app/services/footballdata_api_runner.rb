class FootballDataAPIRunner

  # Configure API at runtime. See documentation for more info:
  # https://github.com/delta4d/football-data
  FootballData.configure do |config|
    # get api key at 'http://api.football-data.org/register'
    config.api_key = ENV["FOOTBALLDATA_API_KEY"]

    # default api version is 'alpha' if not setted
    config.api_version = 'v1'

    # the default control method is 'full' if not setted
    # see request section on 'http://api.football-data.org/documentation'
    config.response_control = 'full'
  end

  def self.get_team(id)
    #Define custom method for fetch since the provided method is terrible
    FootballData.fetch(resource = :teams, subresource = nil, params={id: id})
  end

  def self.create_team(data, counter = nil)
    #Create team in Teams table based on data; if data is not valid a message
    # is returned instead. Provide the counter for more informational message
    if data.keys.include?("error")
      puts "No team entered.\nCounter value: #{counter}\nData: #{data}\n**********"
    else
      Team.new(Team.assignment_hash(data)).tap do |t|
        if t.save
          puts "Team saved.\nName:#{data["name"]}\nid:#{t.id}\n**********"
        else
          puts "!!**TEAM NOT SAVED**!!\nName:#{data["name"]}"
          puts "counter:#{counter}\n#{data["_links"]["self"]["href"]}\n**********"
        end
      end
    end
  end

  def self.get_team_api_id(team_object)
    #given a team object, finds its api id#, such that it can be entered into:
    #http://api.football-data.org/v1/teams/[:id]
    slash_num = team_object.team_url.scan(/\/[0-9]+/).first
    #format of slash_num is: "/###"
    slash_num[1..-1].to_i
  end

  def self.create_next_50(start = nil)
    #Based on last team in teams table, call API for next 50 and create those
    #teams
    start ? counter = start : counter = get_team_api_id(Team.order("id ASC").last) + 1
    max_requests = counter + 50
    while counter < max_requests
      data = get_team(counter)
      create_team(data,counter)
      counter += 1
    end
    puts "***End of Method Reached Successfully!***"
  end

end
