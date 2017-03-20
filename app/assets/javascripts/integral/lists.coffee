document.addEventListener "turbolinks:load", ->
  return unless $(".lists.show").length > 0
  new List()

  $('form').areYouSure()
  
