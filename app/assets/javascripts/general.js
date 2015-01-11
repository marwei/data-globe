$(document).ready(function(){
  $("a").click(function(event){
    event.preventDefault();
    $('#point-form').css("display", "block");
  });
});