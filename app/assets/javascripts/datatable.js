function createDataTable(){
  // Do some weird stuff so this works on /teams but doesn't break
  // highlights/pending (for some reason)
  let selection = $('table#teams-table')
  if (selection[0]){selection.DataTable()}
}

document.addEventListener("turbolinks:load", function() {
  createDataTable();
})
