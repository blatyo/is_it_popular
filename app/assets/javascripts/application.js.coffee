#= require jquery
#= require jquery_ujs
#= require_tree .

$ ->
  $("#stats").click (event) -> 
    event.preventDefault
    if $("#stats").hasClass("off")
      $("#stats").addClass("on").removeClass("off").text("is it popular?")
      $("#popular").slideUp("slow")
      $("#details").slideDown("slow")
    else
      $("#stats").removeClass("on").addClass("off").text("stats")
      $("#popular").slideDown("slow")
      $("#details").slideUp("slow")