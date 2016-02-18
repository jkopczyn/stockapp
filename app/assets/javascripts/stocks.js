$(document).ready(function($) {
  $(".search-form").submit(function(event) {
    event.preventDefault();
    $.ajax({url: "/stocks/symbol/"+$(event.target).find("input").val(),
      datatype: "html",
      success: function(response) {
        $(".search-results").prepend(response);
        $(event.target).find("input").val("Search Again");
      }});
  });
});
