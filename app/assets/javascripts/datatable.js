function createDataTable(){
  $('table#teams-table').DataTable();
}

document.addEventListener("turbolinks:load", function() {
  createDataTable();
})
