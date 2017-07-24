##TODO## (newly prioritized!!)
- FOCUS: getting this up so my database is persistent. All other changes can be
pushed!
- Finish teams index page (use gem?)
- SET UP DEPENDENT DESTROY RELATIONSHIPS
- Add users
- create page to add/edit teams
- create data flow to try to match teams and send to a page to confirm/edit
- Add a rating system to each goal (put top goal on front page?)
- Add comment system
- Create "god" access to be able to delete and edit (team, comments?)
- Add api keys to secrets file
- Bootstrap

- teams show page needs: link to add/edit crest, recent goals section, link to all team goals page (new route)


- Gem for teams#index table: https://github.com/leikind/wice_grid
- Oembed API to embed videos from just a url??
- Error handle HTTP request timeout errors
- Set up cron jobs
- last team id checked was 2871
- create page to add/edit players
- incorporate players into database; use apis to match DONT DO THIS - will take
forever! Figure out another way to create them way to get players (scrape espn
  maybe??), or drop them entirely


## Setup Notes:

**Post number:**
- API post stream seems to give me the newest 100 posts
- From oldest number (top) to newest (bottom); continues to update from there


**Post info of interest (in order)**
*Example post 1*
 - media_embed: {}
 - secure_media:
 - link_flair_text: Official source
 - secure_media_embed: {}
 - domain: twitter.com
 - permalink: /r/soccer/comments/6jpkif/javier_pinola_has_officially_signed_with_river/
 - created: 1498556593.0      ?????
 - url: https://twitter.com/CARPoficial/status/879512821020729345
 - title: Javier Pinola has officially signed with River Plate until 2020
 - created_utc: 1498527793.0  ?????
 - media:
 - is_video: false

*Example post 2*
- media_embed: {:content=>"<iframe class=\"embedly-embed\" src=\"//cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Fstreamable.com%2Ft%2Fws2r0&url=https%3A%2F%2Fstreamable.com%2Fws2r0&image=https%3A%2F%2Fcdn-e2.streamable.com%2Fimage%2Fws2r0.jpg%3Ftoken%3D1499728674_368cb843f12ebeb439b48ef6820dea7157f51d06&key=522baf40bd3911e08d854040d3dc5c07&type=text%2Fhtml&schema=streamable\" width=\"600\" height=\"340\" scrolling=\"no\" frameborder=\"0\" allowfullscreen></iframe>", :width=>600, :scrolling=>false, :height=>340}
- secure_media: {:type=>"streamable.com", :oembed=>{:provider_url=>"https://www.streamable.com", :description=>"Check out this video on Streamable using your phone, tablet or desktop.", :title=>"Streamable - free video publishing", :thumbnail_width=>636, :height=>340, :width=>600, :html=>"<iframe class=\"embedly-embed\" src=\"https://cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Fstreamable.com%2Ft%2Fws2r0&url=https%3A%2F%2Fstreamable.com%2Fws2r0&image=https%3A%2F%2Fcdn-e2.streamable.com%2Fimage%2Fws2r0.jpg%3Ftoken%3D1499728674_368cb843f12ebeb439b48ef6820dea7157f51d06&key=2aa3c4d5f3de4f5b9120b660ad850dc9&type=text%2Fhtml&schema=streamable\" width=\"600\" height=\"340\" scrolling=\"no\" frameborder=\"0\" allowfullscreen></iframe>", :version=>"1.0", :provider_name=>"Streamable", :thumbnail_url=>"https://i.embed.ly/1/image?url=https%3A%2F%2Fcdn-e2.streamable.com%2Fimage%2Fws2r0.jpg%3Ftoken%3D1499728674_368cb843f12ebeb439b48ef6820dea7157f51d06&key=b1e305db91cf4aa5a86b732cc9fffceb", :type=>"video", :thumbnail_height=>360}}
- link_flair_text: Media
- secure_media_embed: {:content=>"<iframe class=\"embedly-embed\" src=\"https://cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Fstreamable.com%2Ft%2Fws2r0&url=https%3A%2F%2Fstreamable.com%2Fws2r0&image=https%3A%2F%2Fcdn-e2.streamable.com%2Fimage%2Fws2r0.jpg%3Ftoken%3D1499728674_368cb843f12ebeb439b48ef6820dea7157f51d06&key=2aa3c4d5f3de4f5b9120b660ad850dc9&type=text%2Fhtml&schema=streamable\" width=\"600\" height=\"340\" scrolling=\"no\" frameborder=\"0\" allowfullscreen></iframe>", :width=>600, :scrolling=>false, :height=>340}
- domain: streamable.com
- permalink: /r/soccer/comments/6jorzi/joel_avaí_goal_vs_botafogo_01/
- created: 1498547887.0
- url: https://streamable.com/ws2r0
- title: Joel (Avaí) goal vs. Botafogo (0-1)
- created_utc: 1498519087.0
- media: {:type=>"streamable.com", :oembed=>{:provider_url=>"https://www.streamable.com", :description=>"Check out this video on Streamable using your phone, tablet or desktop.", :title=>"Streamable - free video publishing", :thumbnail_width=>636, :height=>340, :width=>600, :html=>"<iframe class=\"embedly-embed\" src=\"//cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Fstreamable.com%2Ft%2Fws2r0&url=https%3A%2F%2Fstreamable.com%2Fws2r0&image=https%3A%2F%2Fcdn-e2.streamable.com%2Fimage%2Fws2r0.jpg%3Ftoken%3D1499728674_368cb843f12ebeb439b48ef6820dea7157f51d06&key=522baf40bd3911e08d854040d3dc5c07&type=text%2Fhtml&schema=streamable\" width=\"600\" height=\"340\" scrolling=\"no\" frameborder=\"0\" allowfullscreen></iframe>", :version=>"1.0", :provider_name=>"Streamable", :thumbnail_url=>"https://cdn-e2.streamable.com/image/ws2r0.jpg?token=1499728674_368cb843f12ebeb439b48ef6820dea7157f51d06", :type=>"video", :thumbnail_height=>360}}
- is_video: false
