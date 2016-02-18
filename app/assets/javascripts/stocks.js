$(document).ready(function($) {
  $(".search-form").submit(function(event) {
    event.preventDefault();
    $(event.target).find("button").prop("disabled", true);
    $.ajax({url: "/stocks/symbol/"+$(event.target).find("input").val(),
      datatype: "html",
      success: function(response) {
        $(".search-results").prepend(response);
        $(event.target).find("input").val("Search Again");
        $(event.target).find("button").removeProp("disabled");
      }});
  });
});
