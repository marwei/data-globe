function listHeight() {
  list_height = $(window).height()-$("#point-form").height() - 110;
  $("#points-list").css("height", list_height);
}

$(document).ready(function() {
  listHeight();
});

$(window).resize(function() {
  listHeight();
});