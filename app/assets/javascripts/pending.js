// get everything working here first, then look to environment variables to
// enable production and development to call to different sources


function render(template, selector){
  $(selector).empty()
  $(selector).append(template)
}

function jsonToForm(json){
  let html = `${json.map(highlight => "<div class='jumbotron'>\
  <form class='pending-highlight' action='/highlights/pending' method='post'>\
  <strong><label>Highlight Title: </label></strong>" + highlight.title + "<br>\
  <label><strong>Team Name: </label></strong><input type='text' class='team-input' name='highlight[team]' value='" + highlight.team_id + "'/><br>\
  <strong><label>Source Media: </label></strong><a href='" + highlight.url + "'>" + highlight.domain_id + "</a><br>\
  <strong><label>Reddit Post: </label></strong> <a href='http://www.reddit.com" + highlight.permalink + "'> Link </a><br>\
  <strong><label>Posted (UTC): </label></strong> " + highlight.posted_utc + "<br>\
  <input type='submit' name='submit' value='Submit'/>\
  </form></div>").join("")}`
  render(html, "#pending-highlight-container")
}

function submitForm(){
  $("form.pending-highlight").on("submit", function(event){
    event.preventDefault()
    console.log("submit")
  })
}

function loadPage(){
  fetch("http://localhost:3000/highlights/pendingJSON").
    then(resp => resp.json()).
    then(jsonToForm).
    then(submitForm)
}



$("document").ready(function(){
  loadPage()
})
