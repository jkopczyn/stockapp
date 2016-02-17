$(".search-form").submit(function(event) {
  event.preventDefault();
  $.ajax({url: "/stocks", datatype: "html",
    data: {"ticker_symbol": event.target.val()},
   success: function(response) {
     $(".search-results").prepend(response);
     $(".search-form").html("Search Again");
   }});
});
