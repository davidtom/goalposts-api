# Spotifyzer-api
* Rails API for GoalPosts - an app that aggregates goal highlights from Reddit's /r/soccer
* Provides data and makes Reddit API calls for React front end ([repo](https://github.com/davidtom/goalposts-fe))
* View live site [here](https://goalposts-fe.herokuapp.com/) (please be patient while Heroku wakes up)

## Features
* Responds to requests for highlights with paginated JSON objects
* Includes basic database search and sort functionality
* Employs a rake task to pull highlights from /r/soccer which can be easily scheduled using a gem such as [whenever](https://github.com/javan/whenever) or through [Heroku's Scheduler](https://elements.heroku.com/addons/scheduler)
* Provides authorization for administrators, enabling simple curation functionality from the front end

## Architecture
* See ```app``` for application code
* Utilizes the [Redd Reddit API Wrapper](https://github.com/avinashbot/redd) to access the Reddit API and find goal highlights from /r/soccer
  * In order to use this repo, you must [register](https://www.reddit.com/wiki/api) your app with Reddit and store the client id, secret key, etc. as environment variables (I recommend the [Figaro gem](https://github.com/laserlemon/figaro))
* [PostreSQL](https://www.postgresql.org/) database stores goal highlight information
